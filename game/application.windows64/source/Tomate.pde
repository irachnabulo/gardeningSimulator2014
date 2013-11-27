class Tomate extends Plante {
  
  Tomate() {
    super(color(128,232,0),0,0,30,1);
  }
  
  Tomate(int posX, int posY) {
    super(color(128,232,0),posX,posY,30,1);
  }
  
  void grow(){
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
