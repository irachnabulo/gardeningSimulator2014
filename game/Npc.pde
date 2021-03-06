abstract class Npc {
  int posX;
  int posY;
  int pixX, pixY;
  color c;
  int timer;
  int actionTime, actionTimer = 0;
  int animTimer = 0, animTime;
  int anim = 0;
  int decisionTime;
  int refillSpeed;
  int state, STANDBY = 0, PLANTING = 1, HARVESTING = 2, REFILL = 3, EMPTYBAG = 3; //0 = STANDBY,1 = PLANTING,2 = HARVESTING
  int up = 0, left = 1, right = 2, down = 3;
  Case destination = null;
  int faceDirection;
  
  Npc(int posX, int posY, color c) {
    this.posX = posX;
    this.posY = posY;
    this.c = c;
    decisionTime = 15;
    actionTime = 300;
    animTime = 5;
    timer = 0;
    state = 0;
    faceDirection = down;
    refillSpeed = 3;
    pixX = posX*40;
    pixY = posY*40;
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
      if(posY > 0) {
        pixY-=4;
      }
    }
    else if(direction == 1) { //left
      if(posX > 0)
        pixX-=4;
    }
    else if(direction == 2) { //right
      if(posX < vue.world.nbCasesLargeur-1)
        pixX+=4;
    }
    else { //Down
      if(posY < vue.world.nbCasesHauteur-1)
        pixY+=4;
    }
    if(pixY%40 == 0)
      posY = pixY/40;
    if(pixX%40 == 0)
      posX = pixX/40;
    
    if(direction != faceDirection) {
      faceDirection = direction;
      anim = 0;
      animTimer = 0;
    }
  }
  
  int calcDistance(Case debut, Case fin){
    return abs(debut.getPosY() - fin.getPosY()) + abs(debut.getPosX() - fin.getPosX());
  }
  
  void goTo(Case destination, World world){
    world.jardin[posX][posY].occupee = false;
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
    world.jardin[posX][posY].occupee = true;
  }
  
  void setState(int state){
    this.state = state;
  }
  
  void update(World world){
    takeDecision(world);
  }
  
  void drawNpc() {
    if(state == STANDBY){
      if(faceDirection == up || faceDirection == left)
          image(SKINTONE_WHITE_IDLE_LEFT,pixX,pixY-40);
        else
          image(SKINTONE_WHITE_IDLE_RIGHT,pixX,pixY-40);
    }
    else if((state == PLANTING || state == HARVESTING) && posX == destination.posX && posY == destination.posY) {
        if(faceDirection == up || faceDirection == left)
          image(SKINTONE_WHITE_IDLE_LEFT,pixX,pixY-40);
        else
          image(SKINTONE_WHITE_IDLE_RIGHT,pixX,pixY-40);
    }
    else {
      animTimer++;
      if(animTimer >= animTime) {
        anim++;
        if(anim == NpcImages[faceDirection].length) 
          anim = 0;
        animTimer = 0;
      }
      image(NpcImages[faceDirection][anim],pixX,pixY-40);
    }
  }
  
  abstract void takeDecision(World world);
  abstract Case scanArea(World world);
  
  
}

