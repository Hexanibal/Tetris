enum Couleur{
 
    NULL(40, 40, 40),
    RED(206, 45, 72),
    GREEN(45, 206, 126),
    BLUE(103, 142, 220),
    PURPLE(154, 61, 154),
    ORANGE(223, 149, 54),
    YELLOW(233, 227, 54),
    CYAN(82, 210, 193);
    
    
    int r, g, b;
    private Couleur(int r, int g, int b){
        this.r = r;
        this.g = g;
        this.b = b;
    }
    
    public int getR(){
         return r;   
    }
    
    public int getG(){
         return g;   
    }
    
    public int getB(){
         return b;   
    }
    
    
}