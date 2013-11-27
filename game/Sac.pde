class Sac {
  ArrayList<Plante> plantes;
  int max = 2;
  
  Sac(){
    plantes = new ArrayList<Plante>();
  }
  
  void ajouterPlante(Plante p){
    plantes.add(p);
  }
  
  Plante enleverPlante(){
    Plante p = null;
    if(plantes.size() > 0)
      p = plantes.remove(plantes.size()-1);
    return p;
  }
  
  
}
