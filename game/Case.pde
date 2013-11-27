class Case {
  int posX;
  int posY;
  Entite entite;
  boolean occupee;
  
  Case(int posX, int posY){
    this.posX = posX;
    this.posY = posY;
    entite = null;
    occupee = false;
  }
  
  int getPosX(){
    return posX;
  }
  
  int getPosY(){
    return posY;
  }
  
  void setEntite(Entite e){
    entite = e;
  }
  
  Entite getEntite(){
    return entite;
  }
  
}
