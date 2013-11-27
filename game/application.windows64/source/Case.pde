class Case {
  int posX;
  int posY;
  Entite entite;
  
  Case(int posX, int posY){
    this.posX = posX;
    this.posY = posY;
    entite = null;
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
