import processing.sound.*;


public static boolean showCoords = false;
public static boolean showSpawn = true;

public static int slotSize = 40;

public static int initialSpeed = 450;
public static int speedIncrease = 25;
public static int maxSpeed = 150;
public static int accelerateSpeed = 100;


public static Tetris tetris;


void setup(){
    tetris = new Tetris(10, 20);
    
    //10 * slotSize, 20 * slotSize (+ 4 * slotSize)
    size(400, 960);
    
    thread("loadSound");
    background(40);
    delay(6350);
}


void draw(){
    tetris.update();
}


void keyPressed(){
    
    if(key == 'q' || keyCode == LEFT){
        tetris.moveSideway(-1);
    }
    
    if(key == 'd' || keyCode == RIGHT){
        tetris.moveSideway(1);
    }
    
    if(key == 'z' || keyCode == UP){
        tetris.registerTurn();
    }
    
    if(key == 's' || keyCode == DOWN){
        tetris.registerAccelerate(true);
    }
    
    if(key == ' '){
        tetris.registerDrop();
    }
    
}

void keyReleased(){
    if(key == 's' || keyCode == DOWN){
        tetris.registerAccelerate(false);
    }
}


void stepThread(){
    delay(tetris.getStepSpeed());
    
    while(true){
          tetris.registerStep();
          delay(tetris.getStepSpeed());
     }
}


void loadSound(){
    SoundFile file = new SoundFile(this, "tetris.mp3");
    file.loop(1.05, 0.30);
}