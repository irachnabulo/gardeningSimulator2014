class Harvester extends Npc{
  Sac sac;
  
  Harvester(int posX, int posY) {
    super(posX,posY,color(random(236,256),random(219,239),random(137,157)));
    sac = new Sac();
  }
  
  Harvester(int posX, int posY, Sac sac){
    super(posX,posY,color(150,150,150));
    this.sac = sac;
  }
  
  void harvestSomething(int x, int y,World world){
    if(world.getJardin()[x][y].getEntite() instanceof Plante) {
       sac.ajouterPlante((Plante)world.jardin[x][y].getEntite());
       world.getJardin()[x][y].setEntite(new Terre());
    }
  }
  
  void sell(Plante p) {
    vue.world.goldPiece += p.sellingPrice;
  }
  
  void vendrePlantes() {
    Plante p;
    for(int i = 0; i < sac.plantes.size(); i++) {
      p = sac.enleverPlante();
      sell(p);
    }
    
  }
  
  void takeDecision(World world){
    
    if(destination != null) {
      if(world.jardin[destination.posX][destination.posY].entite instanceof Terre && (destination.posX != posX || destination.posY != posY)) //Si la plante meurt
        state = STANDBY;
    }
    
    //STATE EMPTYBAG
    if(state == EMPTYBAG)
    {
      if(posX < world.nbCasesLargeur/2)
        destination = world.jardin[2][world.nbCasesHauteur-3];
      else
        destination = world.jardin[world.nbCasesLargeur-3][world.nbCasesHauteur-3];
      goTo(destination,world);
      if(posX == destination.posX && posY == destination.posY){
          vendrePlantes();
          state = STANDBY;
          destination = null;
      }
    }
    
    //STATE STANDBY
    if(state == STANDBY) {
      destination = scanArea(world);
      if(destination != null)
        world.jardin[destination.posX][destination.posY].occupee = true;
    }
        
    //CHANGEMENT DE STATE
    if(destination == null)  
      state = EMPTYBAG;
    else
      state = HARVESTING;
    
      
    //STATE HARVESTING
    if(state == HARVESTING && destination != null) {
      goTo(destination,world);
      int distance = abs(posY - destination.getPosY()) + abs(posX - destination.getPosX());
      if(distance <= 0) {
        if(actionTimer == actionTime) {
          if(world.getJardin()[posX][posY].getEntite() instanceof Plante){
            harvestSomething(posX,posY,world);
          }
        }
        else if(actionTime < actionTime)
          actionTimer++;
        else {
          if(sac.plantes.size() == sac.max)
            state = EMPTYBAG;
          else
            state = STANDBY;
          actionTimer = 0;
          destination = null;
        }
      }
    }    
    
    
        
  }
  
  Case scanArea(World world){
    Case c = null;
    int distanceCase;
    int distanceTab;
    for(int i = 0; i < 10; i++) {
      for(int j = 0; j < world.nbCasesLargeur; j++) {
        Case temp = world.jardin[j][i];
        if(temp.getEntite() instanceof Plante && ((Plante)temp.getEntite()).isHarvestable() && !world.jardin[j][i].occupee){
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
  
  void drawNpc() {
    super.drawNpc();
    if(state == STANDBY){
      if(faceDirection == up || faceDirection == left)
          image(HARVESTER_IDLE_LEFT,pixX,pixY-40);
        else
          image(HARVESTER_IDLE_RIGHT,pixX,pixY-40);
    }
    else if((state == PLANTING || state == HARVESTING) && posX == destination.posX && posY == destination.posY) {
        if(faceDirection == up || faceDirection == left)
          image(HARVESTER_IDLE_LEFT,pixX,pixY-40);
        else
          image(HARVESTER_IDLE_RIGHT,pixX,pixY-40);
    }
    else {
      image(HarvesterImages[faceDirection][anim],pixX,pixY-40);
    }
  }
  
  
}

