import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class game extends PApplet {

World world;

public void setup(){
  size(600,400);
  background(166,123,91);
  world = new World(60,30,10);
}

public void draw(){
  world.update();
}












class Case {
  int posX;
  int posY;
  Entite entite;
  
  Case(int posX, int posY){
    this.posX = posX;
    this.posY = posY;
    entite = null;
  }
  
  public int getPosX(){
    return posX;
  }
  
  public int getPosY(){
    return posY;
  }
  
  public void setEntite(Entite e){
    entite = e;
  }
  
  public Entite getEntite(){
    return entite;
  }
  
}
class Entite {
 int c;

 Entite(int c) {
   this.c = c;
 }
 
 public int getCouleur(){
   return c;
 }
 
}
class Harvester extends Npc{
  Sac sac;
  
  Harvester(int posX, int posY) {
    super(posX,posY,color(150,150,150));
    sac = new Sac();
  }
  
  Harvester(int posX, int posY, Sac sac){
    super(posX,posY,color(150,150,150));
    this.sac = sac;
  }
  
  public void harvestSomething(int x, int y){
    if(world.getJardin()[x][y].getEntite() instanceof Tomate) {
       sac.ajouterPlante(new Tomate());
       world.getJardin()[x][y].setEntite(new Terre());
    }
  }
  
  public void takeDecision(World world){
    //STATE STANDBY
    if(!(actionTimer < actionTime) || state == STANDBY)
      destination = scanArea(world);
        
    //CHANGEMENT DE STATE
    if(destination == null) 
      state = STANDBY;
    else 
      state = HARVESTING;
      
    //STATE HARVESTING
    if(state == HARVESTING && destination != null) {
      goTo(destination);
      int distance = abs(posY - destination.getPosY()) + abs(posX - destination.getPosX());
      if(distance <= 0) {
        if(actionTimer < actionTime) {
          actionTimer++;
          if(world.getJardin()[posX][posY].getEntite() instanceof Tomate)
            harvestSomething(posX,posY);
        }
        else { 
          state = STANDBY;
          actionTimer = 0;
          destination = null;
        }
      }
    }    
    
    
        
  }
  
  public Case scanArea(World world){
    Case c = null;
    int distanceCase;
    int distanceTab;
    for(int i = 0; i < 25; i++) {
      for(int j = 0; j < world.nbCasesLargeur; j++) {
        Case temp = world.jardin[j][i];
        if(temp.getEntite() instanceof Tomate && ((Tomate)temp.getEntite()).isHarvestable()) {
          if(c == null)
            distanceCase = 9000;
          else
            distanceCase = calcDistance(world.getJardin()[posX][posY],c);
          distanceTab = calcDistance(world.getJardin()[posX][posY], temp);
          if(c == null || distanceTab < distanceCase) {
            c = temp;
          }
        }
      }
    }
    return c;
  }
  
  
  
}
class Herbe extends Entite{  
  Herbe() {
    super(color(random(140,160),random(182,220),random(0,98)));
  }
}
class Jardinier extends Npc {
  int nbGraines;  
  
  Jardinier(int posX, int posY){
    super(posX,posY,color(50,50,50));
    nbGraines = 0;
  }
  
  public void plantSomething(int x, int y){
    if(world.getJardin()[x][y].getEntite() instanceof Terre) {
      world.getJardin()[x][y].setEntite(new Tomate(x,y));
      nbGraines--;
    }
    
  }
    
  
  public void takeDecision(World world){
    if(state == REFILL){
      if(posX < world.nbCasesLargeur/2)
        destination = world.jardin[2][world.nbCasesHauteur-3];
      else
        destination = world.jardin[world.nbCasesLargeur-2][world.nbCasesHauteur-3];
      goTo(destination);
      if(posX == destination.posX && posY == destination.posY){
        if(actionTimer < actionTime*2) {
          actionTimer++;
          nbGraines+=3;
        }
        else{ 
          state = STANDBY;
          actionTimer = 0;
          destination = null;
        }
      }
    }
    
    //State STANDBY
    if(!(state == REFILL) && !(actionTimer < actionTime) || state == STANDBY) {
      destination = scanArea(world);
      //println("Help.");
    }
    
    //Changement de state
    if(nbGraines == 0)
      state = REFILL;
    else if(destination.getEntite() instanceof Terre)
      state = PLANTING;
    else
      state = STANDBY;
    
    //State PLANTING
    if(state == PLANTING) {
      //println("Going (" + destination.posX + "," + destination.posY + ")");
      goTo(destination);
      int distance = abs(posY - destination.getPosY()) + abs(posX - destination.getPosX());
      if(distance == 0) {
        if(actionTimer < actionTime) {
          //println("Planting");
          actionTimer++;
          if(world.getJardin()[posX][posY].getEntite() instanceof Terre)
              plantSomething(posX,posY);
        }
        else{ 
          state = STANDBY;
          actionTimer = 0;
          destination = null;
         }
       }
     }
     println(nbGraines);
     println("S: " + state);
   }  
  
  public Case scanArea(World world){
    Case c = null;
    int distanceCase;
    int distanceTab;
    for(int i = 0; i < 25; i++) {
      for(int j = 0; j < world.nbCasesLargeur-1; j++) {
        Case temp = world.jardin[j][i];
        if(temp.getEntite() instanceof Terre){
          if(c == null)
            distanceCase = 9000;
          else
            distanceCase = calcDistance(world.getJardin()[posX][posY],c);
          distanceTab = calcDistance(world.getJardin()[posX][posY], temp);
          if(distanceTab < distanceCase)
            c = temp;
        }
      }
    }
    return c;
  }
  
  
  
}
abstract class Npc {
  int posX;
  int posY;
  int c;
  int timer;
  int actionTime, actionTimer = 0;
  int decisionTime;
  int state, STANDBY = 0, PLANTING = 1, HARVESTING = 2, REFILL = 3, EMPTYBAG = 3; //0 = STANDBY,1 = PLANTING,2 = HARVESTING
  int up = 0, left = 1, right = 2, down = 3;
  Case destination = null;
  
  Npc(int posX, int posY, int c) {
    this.posX = posX;
    this.posY = posY;
    this.c = c;
    decisionTime = 15;
    actionTime = 6;
    timer = 0;
    state = 0;
  }
  
  public int getCouleur(){
    return c;
  }
  
  public int getPosX(){
    return posX;
  }
  
  public int getPosY(){
    return posY;
  }
  
  public void move(int direction){    
    if(direction == 0) { //up
      if(posY > 0)
        posY--;
    }
    else if(direction == 1) { //left
      if(posX > 0)
        posX--;
    }
    else if(direction == 2) { //right
      if(posX < world.nbCasesLargeur-1)
        posX++;
    }
    else { //Down
      if(posY < world.nbCasesHauteur-1)
        posY++;
    }
  }
  
  public int calcDistance(Case debut, Case fin){
    return abs(debut.getPosY() - fin.getPosY()) + abs(debut.getPosX() - fin.getPosX());
  }
  
  public void goTo(Case destination){
    
    if(posX != destination.posX){
      if(posY == destination.posY) {
        if( posX < destination.posX)
          move(right);
        else if(posX > destination.posX)
          move(left);
      }
      else{ //diagonal
        if(random(2) == 0) {
          if(posX < destination.posX) 
            move(left);
          else if (posX > destination.posX) 
            move(right);
        }
        else{
          if(posY < destination.posY)
            move(down);
          else if (posY > destination.posY)
            move(up);
        }
      }
    }
    else{
      if(posY < destination.posY)
        move(down);
      else if(posY > destination.posY)
        move(up);
    }
  }
  
  public void setState(int state){
    this.state = state;
  }
  
  public void update(World world){
    timer++;
    if(timer >= decisionTime) {
      takeDecision(world);
      timer = 0;
    }
  }
  
  public abstract void takeDecision(World world);
  public abstract Case scanArea(World world);
}
abstract class Plante extends Entite{
  int prixDeVente;
  int posX;
  int posY;
  int timer;
  int growthTime;
  boolean harvestable;
  
  Plante(int c, int posX, int posY, int growthTime, int prixDeVente) {
    super(c);
    this.posX = posX;
    this.posY = posY;
    this.growthTime = growthTime;
    this.prixDeVente = prixDeVente;
    timer = 0;
    harvestable = false;
  }
  
  public int getCouleur(){
    return c;
  }
  
  public boolean isHarvestable(){
    return harvestable;
  }
  public abstract void grow();
  
}
class Roche extends Entite{
  Roche() {
    super(color(random(125,151)));
  }
}
class Sac {
  ArrayList<Plante> plantes;
  int max = 15;
  
  Sac(){
    plantes = new ArrayList<Plante>();
  }
  
  public void ajouterPlante(Plante p){
    plantes.add(p);
  }
  
  public int viderSac(){
    int nbPlantes = plantes.size();
    plantes.clear();
    return nbPlantes;
  }
  
}
class Terre extends Entite{  
  Terre() {
    super(color(random(131,150),random(112,129),random(23,81)));
  }
  
}
class Tomate extends Plante {
  
  Tomate() {
    super(color(128,232,0),0,0,30,1);
  }
  
  Tomate(int posX, int posY) {
    super(color(128,232,0),posX,posY,30,1);
  }
  
  public void grow(){
    if(timer<60*30)
      timer++;
    if(timer>=growthTime*30 && timer<growthTime*2*30)
      harvestable = true;
    if(timer == growthTime*2*30){
      harvestable = false;
      c = color(154,5,44);
      world.getJardin()[posX][posY].setEntite(new Terre());
    }
    c = color(128 + (91/growthTime)*timer/30,232 - (232/growthTime)*timer/30, 0 + (58/growthTime)*timer/30);
  }
  
}
class World {
  Case[][] jardin;
  Npc[] npcs;
  int NB_NPC = 12;
  int nbCasesLargeur;
  int nbCasesHauteur;
  int tailleCase;
  
  World(int nbCasesLargeur, int nbCasesHauteur, int tailleCase){
    this.nbCasesLargeur = nbCasesLargeur;
    this.nbCasesHauteur = nbCasesHauteur;
    this.tailleCase = tailleCase;
    jardin = new Case[nbCasesLargeur][nbCasesHauteur];
    for(int i = 0; i < nbCasesHauteur; i++){
      for(int j = 0; j < nbCasesLargeur; j++) {
        jardin[j][i] = new Case(j,i);
        if((j%4 == 1 || j%4 ==2) && i<25 && i>1 && j>1 && j<nbCasesLargeur-2)
          jardin[j][i].setEntite(new Terre());
        else
          jardin[j][i].setEntite(new Herbe());
        if(i>=nbCasesHauteur-4 && i < nbCasesHauteur-1) {
          if(j>0 && j <= 3)
            jardin[j][i].setEntite(new Roche());
          else if(j >= nbCasesLargeur-4 && j < nbCasesLargeur-1)
            jardin[j][i].setEntite(new Roche());
        }
      }
    }
    npcs = new Npc[NB_NPC];
    for(int i =0; i < NB_NPC; i+=2){
      if(i%4 == 0 || i%4 == 1) {
        npcs[i] = new Jardinier(nbCasesLargeur-(i+8),nbCasesHauteur-3);
        npcs[i+1] = new Harvester(nbCasesLargeur-(i+8),nbCasesHauteur-2);
      }
      else {
        npcs[i] = new Jardinier(i+8,nbCasesHauteur-3);
        npcs[i+1] = new Harvester(i+8,nbCasesHauteur-2);
      }
    }
  }
  
  
  public void update(){
    
    //Affichage du world
    for(int i = 0; i < nbCasesHauteur; i++){
      for(int j = 0; j<nbCasesLargeur; j++){    
        if(jardin[j][i].getEntite() instanceof Entite) 
          fill(((Entite)jardin[j][i].getEntite()).getCouleur());
        if(jardin[j][i].getEntite() instanceof Plante)
          ((Plante)jardin[j][i].getEntite()).grow();
        stroke(0,0,0,random(50,75));
        rect(jardin[j][i].getPosX()*tailleCase, jardin[j][i].getPosY()*tailleCase, tailleCase, tailleCase);
      }
    }
    
    //Npcs
    for(int i = 0; i < npcs.length; i++){
      npcs[i].update(this);
      fill(npcs[i].getCouleur());
      stroke(0,0,0,random(50,75));
      rect(npcs[i].posX*tailleCase, npcs[i].posY*tailleCase,tailleCase,tailleCase);
    }
    
    
  }
  
  public Case[][] getJardin(){
    return jardin;
  }
  
  public Npc getNpc(int i){
    return npcs[i];
  }  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
