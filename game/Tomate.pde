class Tomate extends Plante {
  
  Tomate() {
    super(color(128,232,0),0,0,(int)random(20,40),1);
  }
  
  Tomate(int posX, int posY) {
    super(color(128,232,0),posX,posY,(int)random(20,40),1);
  }
  
  void grow(){
    if(timer<60*30)
      timer++;
    if(timer>=growthTime*30 && timer<60*30)
      harvestable = true;
    /*if(timer == 80*30){
      harvestable = false;
      vue.world.getJardin()[posX][posY].setEntite(new Terre());
    }*/
    c = color(128 + (91/growthTime)*timer/30,232 - (232/growthTime)*timer/30, 0 + (58/growthTime)*timer/30);
  }
  
}
