class Piece{
 
    private PieceType pieceType;
    
    private PVector loc;
    private ArrayList<PVector> relative;
    private int state;
    
    private boolean moving;
    
    
    
    public Piece(){
        loc = new PVector(5, -3);
        relative = new ArrayList();
        pieceType = PieceType.NULL;
        state = 0;
        moving = true;
        
        
        clearSpawn();
        summonRelative(true, 0);
        updateSlots();
    }
    
    
    
    public void step(){
        if(canStep() && moving){
            
            cleanRelative();
            loc.y = loc.y + 1;
            updateSlots();
             
        }else{
             moving = false;   
        }
    }
    
    
    public void moveSideway(int direction){
        
        if(!canMoveSideWay(direction)) return;
        
        cleanRelative();
        loc.x += direction;
        updateSlots();
    }
    
    
    boolean t;
    PVector sideLoc;
    public boolean canMoveSideWay(int direction){
        t = true;
        
        for(PVector v : relative){
            sideLoc = new PVector(loc.x + v.x + direction, loc.y + v.y);
            
            if(sideLoc.x < 0 || sideLoc.x > Main.tetris.x - 1) t = false;
            
            if(t){
                 if(Main.tetris.getSlot(sideLoc).getColor() == Couleur.NULL){
                     t = true;
                 }else if(isInPiece(sideLoc)){
                     t = true;
                 }else{
                     t = false;
                 }
            }
            
        }
        
        return t;
    }
    
    
    
    boolean b;
    PVector belowLoc;
    private boolean canStep(){
        b = true;
       
        for(PVector v : relative){
            belowLoc = new PVector(loc.x + v.x, loc.y + v.y + 1);
            
            if(belowLoc.y > Main.tetris.y - 1) b = false;
            
            if(b){
                 if(Main.tetris.getSlot(belowLoc).getColor() == Couleur.NULL){
                     b = true;
                 }else if(isInPiece(new PVector(loc.x + v.x, loc.y + v.y + 1))){
                     b = true;
                 }else{
                     b = false;
                 }
            }
            
        }
        
        return b;
    }
    
     
    public PVector getRelative(PVector loc){
        return new PVector(loc.x - this.loc.x, loc.y - this.loc.y);
    }
     
     
    public boolean isInPiece(PVector loc){
        return relative.contains(getRelative(loc));
    }
    
    
    private void updateSlots(){
        cleanRelative();
        summonRelative(false, state);
        for(PVector v : relative){
             Main.tetris.getSlot(new PVector(loc.x + v.x, loc.y + v.y)).setColor(pieceType.getColor());
        }
    }
    
    
    public boolean isEmpty(){
        return relative.size() == 0 ? true : false;   
    }
    
    
    private void clearSpawn(){
        for(int i = 0; i < Main.tetris.x - 1; i++){
            for(int j = -4; j < 0; j++){
                 Main.tetris.getSlot(new PVector(i, j)).setColor(Couleur.NULL);   
            }
        }
    }
    
    
    public boolean isMoving(){
         return moving;   
    }
    
    
    public void stopMoving(){
         moving = false;   
    }
    
    
    public void setMoving(boolean moving){
         this.moving = moving;   
    }
    
    
    public PVector getLocation(){
         return loc;   
    }
    
    
    ArrayList<PVector> slots;
    public ArrayList<PVector> getSlots(){
        slots = new ArrayList();
        for(PVector v : relative){
             slots.add(new PVector(loc.x + v.x, loc.y + v.y));   
        }
        return slots;
    }
    
    
    private void cleanRelative(){
         for(PVector v : relative){
             Main.tetris.getSlot(new PVector(loc.x + v.x, loc.y + v.y)).setColor(Couleur.NULL);
         }
    }
    
    
    public void turn(){
        if(!canTurn()) return;
        state = (state + 1) % 4;
    }
    
    
    ArrayList<PVector> nextRelatives;
    Slot s;
    public boolean canTurn(){
        nextRelatives = getRelativesList(false, (state + 1) % 4);
        
        for(PVector v : nextRelatives){
             s = Main.tetris.getSlot(new PVector(loc.x + v.x, loc.y + v.y));
             if(s.getLocation().x < 0 || s.getLocation().x > Main.tetris.x - 1) return false;
             if(s.getLocation().y < -4 || s.getLocation().y > Main.tetris.y - 1) return false;
             if(Main.tetris.getFixedSlots().contains(s)) return false;
        }
        
        return true;
    }
    
    
    private void summonRelative(boolean random, int turnState){
            relative = new ArrayList();
            relative = getRelativesList(random, turnState);
    }
    
    
    int type;
    ArrayList<PVector> list;
    private ArrayList<PVector> getRelativesList(boolean random, int turnState){
        list = new ArrayList();
        
        type = (random) ? (int) random(7) : pieceType.getValue();
        
            
            //pièce : O
            if(type == 0){
                 pieceType = PieceType.O;
                 list.add(new PVector(-1, 0));
                 list.add(new PVector(0, 0));
                 list.add(new PVector(-1, +1));
                 list.add(new PVector(0, +1));
            }
            
            //pièce : I
            if(type == 1){
                pieceType = PieceType.I;
                if(turnState % 2 == 0){
                    list.add(new PVector(-2, 0));
                    list.add(new PVector(-1, 0));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(+1, 0));
                } else {
                    list.add(new PVector(0, -1));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(0, +1));
                    list.add(new PVector(0, +2));
                }
            }
            
            // pièce : S
            if(type == 2){
                pieceType = PieceType.S;
                if(turnState % 2 == 0){
                    list.add(new PVector(0, 0));
                    list.add(new PVector(+1, 0));
                    list.add(new PVector(-1, +1));
                    list.add(new PVector(0, +1));
                } else {
                    list.add(new PVector(0, -1));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(+1, 0));
                    list.add(new PVector(+1, +1));
                }
            }
            
            // pièce : Z
            if(type == 3){
                pieceType = PieceType.Z;
                if(turnState % 2 == 0){
                     list.add(new PVector(-1, 0));
                     list.add(new PVector(0, 0));
                     list.add(new PVector(0, +1));
                     list.add(new PVector(+1, +1));
                } else {
                     list.add(new PVector(+1, -1));
                     list.add(new PVector(0, 0));
                     list.add(new PVector(+1, 0));
                     list.add(new PVector(0, +1));
                }
            }
            
            // pièce : L
            if(type == 4){
                pieceType = PieceType.L;
                if(turnState == 0){
                    list.add(new PVector(-1, 0));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(+1, 0));
                    list.add(new PVector(-1, +1));
                } else if(turnState == 1){
                    list.add(new PVector(0, -1));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(0, +1));
                    list.add(new PVector(+1, +1));
                } else if(turnState == 2){
                    list.add(new PVector(-1, 0));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(+1, 0));
                    list.add(new PVector(+1, -1));
                } else if(turnState == 3){
                    list.add(new PVector(-1, -1));
                    list.add(new PVector(0, -1));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(0, +1));
                }
            }
            
            // pièce : J
            if(type == 5){
                pieceType = PieceType.J;
                if(turnState == 0){
                    list.add(new PVector(-1, 0));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(+1, 0));
                    list.add(new PVector(+1, +1));
                } else if(turnState == 1){
                    list.add(new PVector(0, -1));
                    list.add(new PVector(+1, -1));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(0, +1));
                } else if(turnState == 2){
                    list.add(new PVector(-1, -1));
                    list.add(new PVector(-1, 0));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(+1, 0));
                } else if(turnState == 3){
                    list.add(new PVector(0, -1));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(0, +1));
                    list.add(new PVector(-1, +1));
                }
            }
            
            // pièce : T
            if(type == 6){
                pieceType = PieceType.T;
                if(turnState == 0){
                    list.add(new PVector(-1, 0));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(+1, 0));
                    list.add(new PVector(0, +1));
                } else if(turnState == 1){
                    list.add(new PVector(0, -1));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(+1, 0));
                    list.add(new PVector(0, +1));
                } else if(turnState == 2){
                    list.add(new PVector(0, -1));
                    list.add(new PVector(-1, 0));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(+1, 0));
                } else if(turnState == 3){
                    list.add(new PVector(0, -1));
                    list.add(new PVector(-1, 0));
                    list.add(new PVector(0, 0));
                    list.add(new PVector(0, +1));
                }
            }
            
            return list;
    }
    
}