abstract class Bouton{
  String texte;
  int x, y, sizeX, sizeY;
  
  Bouton(String texte, int x, int y, int sizeX, int sizeY){
    this.texte = texte;
    this.x = x;
    this.y = y;
    this.sizeY = sizeY;
    this.sizeX = sizeX;
  }
  
  void drawBouton(){
    fill(83,63,0);
    rect(x,y,sizeX,sizeY);
    fill(255);
    text(texte,x+5,y+16);
  }
  
   boolean isOverBox(){
    if (mouseX > x && mouseX < x+sizeX && mouseY > y && mouseY < y+sizeY)
      return true;
    else
      return false;
  }
  
  abstract void press();
  
}
