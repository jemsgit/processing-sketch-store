import processing.svg.*;
float angle2D = radians(30);

boolean rec = false;

void setup() {
  background(255);
  noLoop();
  smooth();
  size(1000,1000);
}

void draw() { 
  int k;
  beginRecord(SVG, "resut1.svg");
  strokeWeight(2);
  stroke(255, 0, 0);
  for(k = 0; k < 37; k++) {
    noFill();
    drawRect(200, 250, 200, 200, k*5, 25);
  }
  endRecord();
  beginRecord(SVG, "resut2.svg");
  stroke(0, 0, 255);
  for(k = 0; k < 37; k++) {
    noFill();
    drawRect(500, 270, 200, 200, k*5, -30);
  }
  endRecord();
  //stroke(0);
  //for(k = 0; k < 37; k++) {
  //  noFill();
  //  drawRect(270, 670, 200, 200, k*5, 20);
  //}
  
}

void drawRect(float initialX, float initialY,int lenx, int lenY, int z, int angle) {
  int dir = 1;
  if(angle < 0) {
    dir = -1;
  }
  initialX = initialX - z*cos(angle2D);
  initialY = initialY - z*sin(angle2D)*dir;
  
  beginShape();
  vertex(initialX, initialY);
  vertex(initialX + (lenx * cos(radians(angle))), initialY - (lenx * sin(radians(angle))));
  vertex(initialX + (lenx * cos(radians(angle))) , initialY + lenY - (lenx * sin(radians(angle))));
  vertex(initialX, initialY + lenY);
  vertex(initialX, initialY);
  endShape();
}
