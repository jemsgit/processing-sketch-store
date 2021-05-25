import processing.svg.*;
float x,y,z;
float delt = 8;

void setup() {
  size(600,600);
  x = width/4;
  y = height/4;
  background(255);
  
  //fill(255, 0, 0);
  noLoop();
}

void draw() {
  beginRaw(SVG, "resut.svg");
  rotateY(PI/6);
  translate(x, y, z);
  stroke(255, 0, 0);
  int k;
  for(k = 0; k < 10; k++) {
    drawCube(0, 0, 20, 40);
    translate(0, 0, k*5);
  }
  for(k = 0; k < 10; k++) {
    translate(0, 0, k*5*-1);
  }
  stroke(0, 255, 0);
  for(k = 0; k < 10; k++) {
    drawCube(200, 0, 20, 40);
    translate(0, 0, k*5);
  }
  endRaw();
}

void drawCube(float initialX, float initialY,int lenx, int lenY) {
  float x = initialX;
  float y = initialY;
  int dir = 1;
  for(int i = 0; i < lenx; i++) {
    beginShape();
    for(int j = 0; j < lenY; j++) {
      curveVertex(x,  y);
      x = x + delt*cos(radians(45))*dir;
      y = y + delt*sin(radians(45));
      dir*=-1;
    }
    y = initialY;
    x = initialX + i * delt;
    endShape();
  }
}
