class Jardinier extends Npc {
  ArrayList<Seed> pouch;
  int pouchCapacity = 3;
  
  Jardinier(int posX, int posY){
    super(posX,posY,color(random(30,70)));
    pouch = new ArrayList<Seed>(pouchCapacity);
    pouch.add(new TomatoSeed());
  }
  
  void plantSomething(int x, int y, World world){
    if(world.getJardin()[x][y].getEntite() instanceof Terre) {
      if(pouch.size() != 0) {
        Seed s = pouch.remove(pouch.size()-1);
        if(s instanceof TomatoSeed)
          world.jardin[x][y].setEntite(new Tomate(x,y));
        else if (s instanceof CornSeed)
          world.jardin[x][y].setEntite(new Corn(x,y));
      }
    }
    
  }
    
  
  void takeDecision(World world){
    if(state == REFILL){
      if(posX < world.nbCasesLargeur/2)
        destination = world.jardin[2][world.nbCasesHauteur-3];
      else
        destination = world.jardin[world.nbCasesLargeur-3][world.nbCasesHauteur-3];
      goTo(destination,world);
      if(posX == destination.posX && posY == destination.posY){
        if(pouch.size() < pouchCapacity) {
          for(int i = 0; i < refillSpeed; i++) {
            if(world.nbGrainesCorn > 0) {
              pouch.add(new CornSeed());
              world.nbGrainesCorn--;
            }
            else if(world.nbGrainesTomate >0) {
              pouch.add(new TomatoSeed());
              world.nbGrainesTomate--;
            }
          }
        }
        else
          state = STANDBY;
      }
    }
    
    //State STANDBY
    if(state == STANDBY) {
      destination = scanArea(world);
      if(destination != null)
        world.jardin[destination.posX][destination.posY].occupee = true;
    }
    
    //Changement de state   
    if(destination != null) {
      if(destination.getEntite() instanceof Terre )
        state = PLANTING;
    }
    else
      state = STANDBY;
    
    //State PLANTING
    if(state == PLANTING) {
      goTo(destination,world);
      int distance = abs(posY - destination.getPosY()) + abs(posX - destination.getPosX());
      if(distance == 0) {
        if(actionTimer == actionTime) {
          if(world.getJardin()[posX][posY].getEntite() instanceof Terre)
              plantSomething(posX,posY, world);
        }
        else if(actionTimer < actionTime)
          actionTimer++;
        else{ 
          if(pouch.size() > 0)
            state = STANDBY;
          else
            state = REFILL;
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
      for(int j = 0; j < world.nbCasesLargeur-1; j++) {
        Case temp = world.jardin[j][i];
        if(temp.getEntite() instanceof Terre && !world.jardin[j][i].occupee){
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
  
  void drawNpc() {
    super.drawNpc();
    if(state == STANDBY){
      if(faceDirection == up || faceDirection == left)
          image(GARDENER_IDLE_LEFT,pixX,pixY-40);
        else
          image(GARDENER_IDLE_RIGHT,pixX,pixY-40);
    }
    else if((state == PLANTING || state == HARVESTING) && posX == destination.posX && posY == destination.posY) {
        if(faceDirection == up || faceDirection == left)
          image(GARDENER_IDLE_LEFT,pixX,pixY-40);
        else
          image(GARDENER_IDLE_RIGHT,pixX,pixY-40);
    }
    else {
      image(GardenerImages[faceDirection][anim],pixX,pixY-40);
    }
  }
  
  
}

