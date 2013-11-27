abstract class Npc {
  int posX;
  int posY;
  color c;
  int timer;
  int actionTime, actionTimer = 0;
  int decisionTime;
  int state, STANDBY = 0, PLANTING = 1, HARVESTING = 2, REFILL = 3, EMPTYBAG = 3; //0 = STANDBY,1 = PLANTING,2 = HARVESTING
  int up = 0, left = 1, right = 2, down = 3;
  Case destination = null;
  
  Npc(int posX, int posY, color c) {
    this.posX = posX;
    this.posY = posY;
    this.c = c;
    decisionTime = 15;
    actionTime = 6;
    timer = 0;
    state = 0;
  }
  
  color getCouleur(){
    return c;
  }
  
  int getPosX(){
    return posX;
  }
  
  int getPosY(){
    return posY;
  }
  
  void move(int direction){    
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
  
  int calcDistance(Case debut, Case fin){
    return abs(debut.getPosY() - fin.getPosY()) + abs(debut.getPosX() - fin.getPosX());
  }
  
  void goTo(Case destination){
    
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
  
  void setState(int state){
    this.state = state;
  }
  
  void update(World world){
    timer++;
    if(timer >= decisionTime) {
      takeDecision(world);
      timer = 0;
    }
  }
  
  abstract void takeDecision(World world);
  abstract Case scanArea(World world);
}
