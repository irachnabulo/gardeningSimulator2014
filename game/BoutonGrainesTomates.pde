class BoutonGrainesTomates extends Bouton{
  
  BoutonGrainesTomates() {
    super("Buy tomato seeds - 5GP for 10",0,0,175,25);
  }
  
  BoutonGrainesTomates(int x, int y) {
    super("Buy tomato seeds - 5GP for 10",x,y,175,25);
  }
  
  void press(){
    if(vue.world.goldPiece >= 5){
      vue.world.goldPiece -=5;
      vue.world.nbGrainesTomate +=10;
    }
  }
}
