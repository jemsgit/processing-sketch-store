float angle2D = radians(30);

void setup() {
  background(255);
  noLoop();
  smooth();
  size(1000,1000);
}

void draw() { 
  int k;
  int x_count = 10;
  int y_count = 7;
  int init_agnle = 20;
  int d_angle = 30/x_count;
  
  stroke(255, 0, 0);

  for(k = 0; k < 70; k++) {
    noFill();
    drawRect3(400, 500, 400, 400, k*4, init_agnle);
  }
  
  for(k = 0; k < 40; k++) {
    noFill();
    //drawRect(430, 550, 100, 100, k*2, -20);
  }
  
  stroke(0, 0, 255);

  for(k = 0; k < 70; k++) {
    noFill();
    drawRect2(470, 330, 400, 400, k*4, init_agnle);
  }
  
  for(k = 0; k < 40; k++) {
    noFill();
    //drawRect(520, 380, 100, 100, k*2, -20);
  }
  
  //stroke(0, 0, 255);
  //for(k = 0; k < 37; k++) {
  //  noFill();
  //  drawRect(500, 270, 200, 200, k*5, -30);
  //}
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
  initialX = initialX - z*cos(angle2D)*dir;
  initialY = initialY - z*sin(angle2D);
  
  beginShape();
  vertex(initialX, initialY);
  vertex(initialX + (lenx * cos(radians(angle))), initialY - (lenx * sin(radians(angle))));
  vertex(initialX + (lenx * cos(radians(angle))) , initialY + lenY - (lenx * sin(radians(angle))));
  vertex(initialX, initialY + lenY);
  vertex(initialX, initialY);
  endShape();
}

void drawRect2(float initialX, float initialY,int lenx, int lenY, int z, int angle) {
  int dir = 1;
  if(angle < 0) {
    dir = -1;
  }
  initialX = initialX - z*cos(angle2D)*dir;
  initialY = initialY - z*sin(angle2D);
  
  beginShape();
  
  vertex(initialX + (lenx * cos(radians(angle))), initialY - (lenx * sin(radians(angle))));
  vertex(initialX, initialY);
  vertex(initialX, initialY + lenY);
  vertex(initialX + (lenx * cos(radians(angle))) , initialY + lenY - (lenx * sin(radians(angle))));
  vertex(initialX + (lenx * cos(radians(angle))) , initialY + lenY + (lenx * sin(radians(angle))));
  endShape();
}

void drawRect3(float initialX, float initialY,int lenx, int lenY, int z, int angle) {
  int dir = 1;
  if(angle < 0) {
    dir = -1;
  }
  initialX = initialX - z*cos(angle2D)*dir;
  initialY = initialY - z*sin(angle2D);
  
  beginShape();
  
  
  //vertex(initialX, initialY + lenY);
  vertex(initialX, initialY);
  vertex(initialX + (lenx * cos(radians(angle))), initialY - (lenx * sin(radians(angle))));

  vertex(initialX + (lenx * cos(radians(angle))) , initialY + lenY - (lenx * sin(radians(angle))));
  vertex(initialX, initialY + lenY);
  vertex(initialX, initialY + lenY + lenY);
  endShape();
}
