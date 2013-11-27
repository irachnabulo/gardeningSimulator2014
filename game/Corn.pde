class Corn extends Plante {
  int r = 125, r2 = 355; //255
  int g = 159, g2 = 331; //231
  int b = 1, b2 = 115; //115
  
  Corn() {
    super(color(0,0,0),0,0,(int)random(80,85),10);
    c = color(r,g,b);
  }
  
  Corn(int posX, int posY) {
    super(color(0,0,0),posX,posY,(int)random(80,85),10);
    c = color(r,g,b);
  }
  
  void grow(){
    if(timer<140*30)
      timer++;
    if(timer>=growthTime*30 && timer<140*30)
      harvestable = true;
    /*if(timer == 120*30){
      harvestable = false;
      vue.world.getJardin()[posX][posY].setEntite(new Terre());
    }*/
    
    c = color(r + ((r2-r)/growthTime)*timer/30,g + ((g2-g)/growthTime)*timer/30,b + ((b2-b)/growthTime)*timer/30);
  }
  
}
