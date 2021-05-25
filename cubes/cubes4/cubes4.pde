import processing.svg.*;
float angle2D = radians(30);

PGraphics pg1;
PGraphics pg2;
PGraphics p;
boolean record = true;

void setup() {
  background(255);
  noLoop();
  smooth();
  size(1000,1000);
  
  pg1 = createGraphics(1000, 1000, SVG, "out1.svg"); //to save
  pg2 = createGraphics(1000, 1000, SVG, "out2.svg"); //to save
  
}

void draw() {
  int k;
  int x_count = 10;
  int y_count = 7;
  int init_agnle = 30;
  int d_angle = 30/x_count;
    pg1.beginDraw();
  pg1.noFill();
  pg2.beginDraw();
  pg2.noFill();
  
  if(record) {
    pg1.background(255);
    pg2.background(255);
    pg1.strokeWeight(1);
    pg2.strokeWeight(1);
  }


  pg1.stroke(255, 0, 0);
  pg2.stroke(0, 0, 255);
  for(int j = 0; j < y_count; j++) {
 
    for(int i = 0; i < x_count; i++) {
      if(random(0,1) > 0.6) {
      stroke(255, 0, 0);
      p = pg1;
    } else {
      stroke(0, 0, 255);
      p = pg2;
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
        p = pg1;
      } else {
        stroke(0, 0, 255);
        p = pg2;
      }
      if(random(0,1) > 0.2) {
        for(k = 2+j; k > 0; k--) {
          noFill();
          drawRect(0 + i*100, 400 + (y_count -j)*60, 40, 40, k*4, init_agnle - d_angle*(x_count -i));
  
        }
      }
    }
  }
  
  pg2.endDraw();
  pg1.endDraw();
  
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
  if(record) {
    p.beginShape();
    p.vertex(initialX, initialY);
    p.vertex(initialX + (lenx * cos(radians(angle))), initialY - (lenx * sin(radians(angle))));
    p.vertex(initialX + (lenx * cos(radians(angle))) , initialY + lenY - (lenx * sin(radians(angle))));
    p.vertex(initialX, initialY + lenY);
    p.vertex(initialX, initialY);
    p.endShape();
  }
  beginShape();
  vertex(initialX, initialY);
  vertex(initialX + (lenx * cos(radians(angle))), initialY - (lenx * sin(radians(angle))));
  vertex(initialX + (lenx * cos(radians(angle))) , initialY + lenY - (lenx * sin(radians(angle))));
  vertex(initialX, initialY + lenY);
  vertex(initialX, initialY);
  endShape();
}
