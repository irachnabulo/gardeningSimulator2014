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
  
  void harvestSomething(int x, int y){
    if(world.getJardin()[x][y].getEntite() instanceof Tomate) {
       sac.ajouterPlante(new Tomate());
       world.getJardin()[x][y].setEntite(new Terre());
    }
  }
  
  void takeDecision(World world){
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
  
  Case scanArea(World world){
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
