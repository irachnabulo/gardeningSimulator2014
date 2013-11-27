class Jardinier extends Npc {
  int nbGraines;  
  
  Jardinier(int posX, int posY){
    super(posX,posY,color(50,50,50));
    nbGraines = 0;
  }
  
  void plantSomething(int x, int y){
    if(world.getJardin()[x][y].getEntite() instanceof Terre) {
      world.getJardin()[x][y].setEntite(new Tomate(x,y));
      nbGraines--;
    }
    
  }
    
  
  void takeDecision(World world){
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
  
  Case scanArea(World world){
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
