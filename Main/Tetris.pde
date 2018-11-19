class Tetris{
    
    private int x = 0;
    private int y = 0;
    
    private ArrayList<Slot> slots;
    private ArrayList<Slot> fixedSlots;
    
    private Piece currentPiece;
    private int speed;
    private int score;
    
    private boolean alive;
    
    private boolean step;
    private boolean turn;
    private boolean drop;
    private boolean accelerate;
    
    
    
    public Tetris(int x, int y){
        this.x = x;
        this.y = y;
        
        slots = new ArrayList();
        fixedSlots = new ArrayList();
        currentPiece = null;
          
        speed = initialSpeed;
        alive = true;
        drop = false;
        accelerate = false;
        turn = false;
        step = false;
        score = 0;
        
        for(int i = 0; i < 10; i++){
             for(int j = -4; j < 20; j++){
                 slots.add(new Slot(new PVector(i, j), Couleur.NULL));
             }
        }
        
        thread("stepThread");
    }
    
    
    
    public void update(){
        death();

        updatePieces();
        
        display();
    }
    
    
    
    public void display(){
         background(40);
         
         for(Slot slot : slots){
             slot.display();
         }
         
         if(!alive){
             fill(255, 100);
             rect(0, 0, width, height);
         }
         
         if(Main.showSpawn){
             strokeWeight(4);
             stroke(255, 0, 0);
             line(0, 40 * 4, 400, 40 * 4);
         }
         
         fill(255);
         textFont(createFont("Arial Bold", 30));
         text(score, 15, 35);
    }
    
    
    boolean t = true;
    private void death(){
        
        for(int i = 0; i < x; i++){
             if(t && fixedSlots.contains(getSlot(new PVector(i, 0)))){
                 t = false;
             }
        }
        
        if(!t){
            alive = false;
        }
    }
    
    
    private void updatePieces(){
         if(!alive) return;
        
         if(currentPiece == null) summonPiece();
         
         currentPiece.updateSlots();
         
         drop();
         turn();
         step();
         
         
         //si la piece vient de s'arrêter
         if(!currentPiece.isMoving()){
             
             for(PVector v : currentPiece.getSlots()){
                  fixedSlots.add(getSlot(v));   
             }
             
             lines();
             
             summonPiece();
         }
    }
    
    
    /*===================================*/
    
    
    public void step(){
        if(!step) return;  
        
        currentPiece.step();
        step = false;
    }
    
    
    public void turn(){
        if(!turn) return;
        currentPiece.turn();
        turn = false;
    }
    
    
    public void moveSideway(int direction){
        currentPiece.moveSideway(direction);
    }
    
    
    public void drop(){
        if(!drop || !alive) return;
        
        do{
            currentPiece.step();
        }while(currentPiece.canStep());

        drop = false;
        currentPiece.stopMoving();
    }
    
    
    /*===================================*/
    
    
    boolean b;
    Slot s = null;
    private void lines(){
        
        for(int j = 0; j < y; j++){
            
            b = true;
            for(int i = 0; i < x && b; i++){
                 b = fixedSlots.contains(getSlot(new PVector(i, j)));   
            }
            
            
            if(b){
                //println("ligne " + j + " complete");  
                
                for(int k = 0; k < x; k++){
                     s = getSlot(new PVector(k, j));
                     s.setColor(Couleur.NULL);
                     fixedSlots.remove(s);   
                }
                
                
                for(int o = 0; o < x; o++){
                    for(int p = j; p > 0; p--){
                        s = getSlot(new PVector(o, p));
                        fixedSlots.remove(s);
                        s.setColor(getSlot(new PVector(o, p - 1)).getColor());
                        if(s.getColor() != Couleur.NULL) fixedSlots.add(s);
                    }
                }
                
                speed -= (speed > maxSpeed) ? speedIncrease : 0;
                
                score += initialSpeed - speed;
            }
        }
    }
    
    
    private void summonPiece(){
        currentPiece = new Piece();
    }
    
    
    public Slot getSlot(PVector loc){
        for(Slot slot : slots){
             if(slot.getLocation().x == loc.x && slot.getLocation().y == loc.y) return slot;
        }
        
        return new Slot(loc, Couleur.NULL);   
    }
    
    
    /*===================================*/
    
    
    public Piece getCurrentPiece(){
        return currentPiece;   
    }

    public int getStepSpeed(){
        return (accelerate) ? accelerateSpeed : speed;
    }
    
    public void registerStep(){
         step = true;   
    }

    public void registerDrop(){
         drop = true;   
    }
    
    public void registerTurn(){
         turn = true;   
    }

    public void registerAccelerate(boolean b){
        accelerate = b;
    }
    
    public ArrayList<Slot> getFixedSlots(){
         return fixedSlots;   
    }
    
    public int getScore(){
         return score;   
    }
}