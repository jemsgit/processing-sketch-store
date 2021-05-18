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
  int init_agnle = 30;
  int d_angle = 30/x_count;

  for(int j = 0; j < y_count; j++) {
 
    for(int i = 0; i < x_count; i++) {
      if(random(0,1) > 0.6) {
      stroke(255, 0, 0);
    } else {
      stroke(0, 0, 255);
    }
      for(k = 0; k < 2 + j; k++) {
        noFill();
        drawRect(30 + i*100, 50 + j*60, 40, 40, k*4, init_agnle - d_angle*i);
      }
    }
  }
  init_agnle = -1;
  for(int j = 0; j < y_count; j++) {
    for(int i = 0; i < x_count; i++) {
      if(random(0,1) > 0.3) {
        stroke(255, 0, 0);
      } else {
        stroke(0, 0, 255);
      }
      if(random(0,1) > 0.2) {
        for(k = 2+j; k > 0; k--) {
          noFill();
          drawRect(0 + i*100, 400 + (y_count -j)*60, 40, 40, k*4, init_agnle - d_angle*(x_count -i));
        }
      }
    }
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
