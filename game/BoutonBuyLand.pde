class BoutonBuyLand extends Bouton{
  
  BoutonBuyLand() {
    super("Buy land - 100GP",0,0,100,25);
  }
  
  BoutonBuyLand(int x, int y) {
    super("Buy land - 100GP",x,y,100,25);
  }
  
  void press(){
    if(vue.world.goldPiece >= 100){
      vue.world.goldPiece-=100;
      vue.world.allocateRock();
    }
  }
}
