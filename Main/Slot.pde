class Slot{
    
    private PVector loc;
    private Couleur couleur;
    
    
    public Slot(PVector loc, Couleur couleur){
        this.loc = loc;
        this.couleur = couleur;
    }
    
    
    public void display(){
        stroke(50);
        strokeWeight(1);
        fill(couleur.getR(), couleur.getG(), couleur.getB());
        rect(loc.x * slotSize, (loc.y + (Main.showSpawn ? 4 : 0)) * slotSize, slotSize, slotSize);
        
        
        if(Main.showCoords){
            fill(255);
            text(loc.x + " " + loc.y, loc.x * slotSize + 10, (loc.y + (Main.showSpawn ? 4 : 0)) * slotSize + 25);
        }
    }
    
    public PVector getLocation(){
         return loc;   
    }
    
    public Couleur getColor(){
         return couleur;   
    }
    
    public void setColor(Couleur couleur){
         this.couleur = couleur;   
    }
    
}