class Sac {
  ArrayList<Plante> plantes;
  int max = 15;
  
  Sac(){
    plantes = new ArrayList<Plante>();
  }
  
  void ajouterPlante(Plante p){
    plantes.add(p);
  }
  
  int viderSac(){
    int nbPlantes = plantes.size();
    plantes.clear();
    return nbPlantes;
  }
  
}
