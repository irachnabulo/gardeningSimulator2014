abstract class Plante extends Entite{
  int sellingPrice;
  int posX;
  int posY;
  int timer;
  int growthTime;
  boolean harvestable;
  
  Plante(color c, int posX, int posY, int growthTime, int sellingPrice) {
    super(c);
    this.posX = posX;
    this.posY = posY;
    this.growthTime = growthTime;
    this.sellingPrice = sellingPrice;
    timer = 0;
    harvestable = false;
  }
  
  color getCouleur(){
    return c;
  }
  
  boolean isHarvestable(){
    return harvestable;
  }
  abstract void grow();
  
}
