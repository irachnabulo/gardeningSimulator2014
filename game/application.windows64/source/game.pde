World world;

void setup(){
  size(600,400);
  background(166,123,91);
  world = new World(60,30,10);
}

void draw(){
  world.update();
}












