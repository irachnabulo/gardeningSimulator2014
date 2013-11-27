class BoutonGrainesCorn extends Bouton{
  
  BoutonGrainesCorn() {
    super("Buy Corn Seeds - 8GP for 1",0,0,170,25);
  }
  
  BoutonGrainesCorn(int x, int y) {
    super("Buy Corn Seeds - 8GP for 1",x,y,170,25);
  }
  
  void press(){
    if(vue.world.goldPiece >= 8){
      vue.world.goldPiece -=8;
      vue.world.nbGrainesCorn++;
    }
  }
}
