class CaseInfo {
  String informations;
  int x, y;
  
  CaseInfo(int x,int y){
    informations = "";
    this.x = x;
    this.y = y;
  }
  
  void drawCaseInfo(PFont f){
    informations = "";
    ajouterInfo("Tomato Seeds: " + vue.world.nbGrainesTomate);
    ajouterInfo("Corn Seeds: " + vue.world.nbGrainesCorn);
    ajouterInfo("GP: " + vue.world.goldPiece);
    
    fill(83,63,0);
    rect(x,y,150,100);
    fill(255);
    text(informations,x+5,y+5);
  }
  
  void ajouterInfo(String s) {
    informations+= "\n" + s;
  }
  
}
