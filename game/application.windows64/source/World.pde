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
    for(int i = 0; i < npcs.length; i++){
      npcs[i].update(this);
      fill(npcs[i].getCouleur());
      stroke(0,0,0,random(50,75));
      rect(npcs[i].posX*tailleCase, npcs[i].posY*tailleCase,tailleCase,tailleCase);
    }
    
    
  }
  
  Case[][] getJardin(){
    return jardin;
  }
  
  Npc getNpc(int i){
    return npcs[i];
  }  
}
