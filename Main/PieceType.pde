enum PieceType{
 
    O(Couleur.YELLOW, 0),
    I(Couleur.CYAN, 1),
    S(Couleur.GREEN, 2),
    Z(Couleur.RED, 3),
    L(Couleur.ORANGE, 4),
    J(Couleur.BLUE, 5),
    T(Couleur.PURPLE, 6),
    NULL(Couleur.NULL, 7);
    
    Couleur couleur;
    int value;
    private PieceType(Couleur couleur, int value){
        this.couleur = couleur;
        this.value = value;
    }
    
    public Couleur getColor(){
         return couleur;   
    }
    
    public int getValue(){
         return value;   
    }
}