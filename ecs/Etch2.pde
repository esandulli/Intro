// Etch A Sketch | Elena Sandulli | 4/18/23

int x, y;
PImage john;

void setup() {
  size(800,650);
  x=width/2;
  y=height/2;
  background(128);
  john=loadImage("Etch.png");
  
}

void draw() {
  image(john,0,0);
}

void mousePressed() {}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == UP) {
      moveUp(10);
    } else if(keyCode == DOWN) {
      moveDown(10);
    } else if (keyCode == LEFT) {
      moveLeft(10);
    } else if (keyCode == RIGHT) {
      moveRight(10);
    } 
  }
} 

void moveRight(int rep) {
  for(int i=0; i<rep; i=i+1) {
    point(x+i,y);
  }
  x=x+rep;
}

void moveLeft(int rep) {
  for(int i=0; i<rep; i=i+1) {
    point(x-i,y);
  }
  x=x-rep;
}
void moveUp(int rep) {
  for(int i=0; i<rep; i=i+1) {
    point(x,y-i);
  }
  y=y-rep;
}
void moveDown(int rep) {
  for(int i=0; i<rep; i=i+1) {
    point(x,y+i);
  }
  y=y+rep;
}
