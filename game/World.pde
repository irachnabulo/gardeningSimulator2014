class World {
  Case[][] jardin;
  ArrayList<Npc> npcs;
  int NB_NPC = 4;
  int nbCasesLargeur;
  int nbCasesHauteur;
  int tailleCase;
  int nbGrainesTomate;
  int nbGrainesCorn;
  int goldPiece;
  char lastWayPoint; //'D' ou 'G'
  
  World(int nbCasesLargeur, int nbCasesHauteur, int tailleCase){
    this.nbCasesLargeur = nbCasesLargeur;
    this.nbCasesHauteur = nbCasesHauteur;
    this.tailleCase = tailleCase;
    nbGrainesTomate = 40;
    nbGrainesCorn = 10;
    goldPiece = 200;
    lastWayPoint = 'D';
    jardin = new Case[nbCasesLargeur][nbCasesHauteur];
    
    //Creation des lignes de roche
    for(int i = 0; i < nbCasesHauteur; i++){
      for(int j = 0; j < nbCasesLargeur; j++) {
        jardin[j][i] = new Case(j,i);
        if((j%5 == 1 || j% 5 == 3) && i<10 && i>1 && j>0 && j<nbCasesLargeur-1) {
            jardin[j][i].setEntite(new Roche());
        }
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
    
    //Allocation de 50 cases de terre
    for(int i = 0; i<50; i++)
      allocateRock();
    
    //Creation des npcs
    npcs = new ArrayList();
    for(int i =0; i < NB_NPC; i+=2){
      if(i == 0) {
        npcs.add(new Jardinier(nbCasesLargeur-(i+6),nbCasesHauteur-3));
        npcs.add(new Harvester(nbCasesLargeur-(i+6),nbCasesHauteur-2));
      }
      else {
        npcs.add(new Jardinier(i+5,nbCasesHauteur-3));
        npcs.add(new Harvester(i+5,nbCasesHauteur-2));
      }
    }
  }
  
  
  void update(){
    
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
    for(int i = 0; i < npcs.size(); i++){
      npcs.get(i).update(this);
      /*fill(npcs.get(i).getCouleur());
      stroke(0,0,0,random(50,75));
      rect(npcs.get(i).pixX, npcs.get(i).pixY,tailleCase,tailleCase);*/
      npcs.get(i).drawNpc();
    }
    
    
  }
  
  void allocateRock(){
    Case aAllouer = scanArea();
    if(aAllouer != null)
      jardin[aAllouer.posX][aAllouer.posY].setEntite(new Terre());
  }
  
  void addHarvester(){
    npcs.add(new Harvester(2,nbCasesHauteur-3));
    npcs.add(new Harvester(nbCasesLargeur-3,nbCasesHauteur-3));
  }
  
  int calcDistance(Case debut, Case fin){
    return abs(debut.getPosY() - fin.getPosY()) + abs(debut.getPosX() - fin.getPosX());
  }
  
  Case scanArea(){
    int posX, posY;
    if(lastWayPoint == 'D') {
      posX = 2;
      posY = nbCasesHauteur-3;
      lastWayPoint = 'G';
    }
    else {
      posX = nbCasesLargeur-3;
      posY = nbCasesHauteur-3;
      lastWayPoint = 'D';
    }
    Case c = null;
    int distanceCase;
    int distanceTab;
    for(int i = 0; i < 10; i++) {
      for(int j = 0; j < nbCasesLargeur-1; j++) {
        Case temp = jardin[j][i];
        if(temp.getEntite() instanceof Roche){
          if(c == null)
            distanceCase = 9000;
          else
            distanceCase = calcDistance(jardin[posX][posY],c);
          distanceTab = calcDistance(jardin[posX][posY], temp);
          if(distanceTab < distanceCase)
            c = temp;
        }
      }
    }
    
    return c;
  }
  
  Case[][] getJardin(){
    return jardin;
  }
  
  
}
