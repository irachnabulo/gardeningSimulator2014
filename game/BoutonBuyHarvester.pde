class BoutonBuyHarvester extends Bouton{
  
  BoutonBuyHarvester() {
    super("Buy harvester - 200GP for 2",0,0,155,25);
  }
  
  BoutonBuyHarvester(int x, int y) {
    super("Buy harvester - 200GP for 2",x,y,155,25);
  }
  
  void press(){
    if(vue.world.goldPiece >= 200){
      vue.world.goldPiece-=200;
      vue.world.addHarvester();
    }
  }
}
