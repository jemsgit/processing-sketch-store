import processing.svg.*;
float x,y,z;
float delt = 8;
float angle2D = radians(30);

boolean rec = false;

void setup() {
  size(600,600);
  x = width/4;
  y = height/4;
  background(255);
  noFill();
  strokeWeight(1);
  //fill(255, 0, 0);
  noLoop();
}

void draw() {
  translate(x, y);translate(x, y);
  beginRecord(SVG, "resut.svg");
  //rotateY(PI/6);
  stroke(255, 0, 0);
  int k;
  for(k = 0; k < 10; k++) {
    noFill();
    drawCube(0, 0, 20, 40, k*5);
  }
  endRecord();
  beginRecord(SVG, "resut2.svg");
  stroke(0, 0, 255);
  for(k = 0; k < 10; k++) {
    noFill();
    drawCube(143, 0, 20, 40,k*5);
  }
  endRecord();
}

void drawCube(float initialX, float initialY,int lenx, int lenY, int z) {
  float x = initialX - z*cos(angle2D);
  float y = initialY - z*sin(angle2D);
  int dir = 1;
  for(int i = 0; i < lenx; i++) {
    beginShape();
    noFill();
    for(int j = 0; j < lenY; j++) {
      curveVertex(x,  y);
      x = x + delt*cos(radians(45))*dir;
      y = y + delt*sin(radians(45));
      dir*=-1;
    }
    y = initialY - z*sin(angle2D);
    x = initialX - z*cos(angle2D) + i * delt;
    endShape();
  }
}
