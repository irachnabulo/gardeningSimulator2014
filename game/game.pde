Vue vue;

PImage NpcImages[][];
PImage GardenerImages[][];
PImage HarvesterImages[][];

PImage SKINTONE_WHITE_IDLE_LEFT;
PImage SKINTONE_WHITE_IDLE_RIGHT;
PImage HARVESTER_IDLE_LEFT;
PImage HARVESTER_IDLE_RIGHT;
PImage GARDENER_IDLE_LEFT;
PImage GARDENER_IDLE_RIGHT;

void setup(){
  size(800,800);
  background(166,123,91);
  vue = new Vue();
  NpcImages = new PImage[4][];
  GardenerImages = new PImage[4][];
  HarvesterImages = new PImage[4][];
  for(int i = 0; i<NpcImages.length; i++) {
    if(i == 0){ //up
      NpcImages[i] = new PImage[6];
      GardenerImages[i] = new PImage[6];
      HarvesterImages[i] = new PImage[6];
    }
    else if(i == 1){ //left
      NpcImages[i] = new PImage[4];
      GardenerImages[i] = new PImage[4];
      HarvesterImages[i] = new PImage[4];
    }
    else if(i == 2){ //right
      NpcImages[i] = new PImage[4];
      GardenerImages[i] = new PImage[4];
      HarvesterImages[i] = new PImage[4];
    }
    else { //down
      NpcImages[i] = new PImage[6];
      GardenerImages[i] = new PImage[6];
      HarvesterImages[i] = new PImage[6];
    }
    for(int j = 0; j < NpcImages[i].length; j++) {
      NpcImages[i][j] = loadImage("images\\animations\\genericHumanoidWhiteWalk" + i + "\\" + j + ".png");
      GardenerImages[i][j] = loadImage("images\\animations\\gardenerHumanoidWalk" + i + "\\" + j + ".png");
      HarvesterImages[i][j] = loadImage("images\\animations\\harvesterHumanoidWalk" + i + "\\" + j + ".png");
    }
  }  
  SKINTONE_WHITE_IDLE_LEFT = loadImage("images\\skintones\\whiteIdle1.png");
  SKINTONE_WHITE_IDLE_RIGHT = loadImage("images\\skintones\\whiteIdle2.png");
  HARVESTER_IDLE_LEFT = loadImage("images\\suits\\harvesterIdleLeft.png");
  HARVESTER_IDLE_RIGHT = loadImage("images\\suits\\HarvesterIdleRight.png");
  GARDENER_IDLE_LEFT = loadImage("images\\suits\\GardenerIdleLeft.png");
  GARDENER_IDLE_RIGHT = loadImage("images\\suits\\gardenerIdleRight.png");
  
}

void draw(){
  vue.world.update();
  vue.drawVue();
}

void mousePressed() {
  vue.getBouton();
}

