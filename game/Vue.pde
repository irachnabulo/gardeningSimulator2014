class Vue{
  World world;
  ArrayList<Bouton> boutons;
  CaseInfo info;
  PFont f;
  
  Vue() {
    /*boutons = new ArrayList<Bouton>();
    boutons.add(new BoutonGrainesTomates());
    boutons.add(new BoutonGrainesCorn());
    boutons.add(new BoutonBuyLand());
    boutons.add(new BoutonBuyHarvester());
    
    int j = -1, k = 0;
    for(int i = 0; i < boutons.size(); i++) {
      if(305+j*30 < height - 35)
        j++;
      else {
        j = 0;
        k++;
      }
      boutons.get(i).y = 305 + j*30;
      boutons.get(i).x = 155 + k*180;
      
    }
    */
    world = new World(20,20,40);
    /*f = createFont("Arial",16,true);
    info = new CaseInfo(0,300);*/
  }
  
  void drawVue() {
    /*fill(166,123,91);
    stroke(255);
    rect(0,400,600,100);
    
    info.drawCaseInfo(f);
    for(int i = 0; i < boutons.size(); i++)
      boutons.get(i).drawBouton();*/
  }
  
  void getBouton(){
    /*for(int i = 0; i < boutons.size(); i++){
      if(boutons.get(i).isOverBox())
        boutons.get(i).press();
    }*/
  }
  
}
