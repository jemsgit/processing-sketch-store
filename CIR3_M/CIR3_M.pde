import processing.svg.*;
float startAngle;
float density;
float radius;
color[] colors = {color(255, 0, 0), color(0, 153, 255)};
int[] angels = {-45, 0, 30, 45, 60, 90};
PGraphics pg1;
PGraphics pg2;

boolean draw = false;

void setup() {
  size(1200,1200);
  smooth();
  if(draw) {
    pg1 = createGraphics(1200, 1200);
    pg2 = createGraphics(1200, 1200);
  } else {
    pg1 = createGraphics(1200, 1200, SVG, "out1.svg"); //to save
    pg2 = createGraphics(1200, 1200, SVG, "out2.svg"); //to save
  }
  noFill();
  noLoop();
  radius = 60;
  density = 0.1;
  
}
void draw() {
  pg1.beginDraw();
  pg1.noFill();
  pg1.background(255);
  pg2.beginDraw();
  pg2.noFill();
  if(draw) {
    pg2.background(255, 1);
  } else {
    pg2.background(255);
  }
  pg1.strokeWeight(1);
  pg2.strokeWeight(1);
  int x_d = 90;
  int y_d = 90;
  PGraphics p;
  for(int i = 0; i< 9; i++) {
     for(int j = 0; j< 12; j++) {
       color c;
       if(i+j < 8) {
         c = colors[0];
         p = pg1;
         if(random(0,2) > 1.4) {
           c = colors[1];
           p = pg2;
         }
         p.stroke(c);
         
         hatch_circle_center((i+1)*x_d, (j+1)*y_d, radius, angels[(int)random(0, 6)], 0.13, -0.8, 1, p);
       } else if(i+j>12){
         c = colors[1];
         p = pg2;
         if(random(0,2) > 1.4) {
           c = colors[0];
           p = pg1;
         }
         p.stroke(c);
         hatch_circle_center((i+1)*x_d, (j+1)*y_d, radius, angels[(int)random(0, 6)], 0.13, -0.8, 0.8, p);
       } else {
         c = colors[(int)random(0,2)];
         PGraphics p;
         if(c == colors[0]) {
           p = pg1;
         } else {
           p = pg2;
         }
         p.stroke(c);
         hatch_circle_center_r((i+1)*x_d, (j+1)*y_d, radius, angels[(int)random(0, 6)], 0.13, random(-0.7,-0.5), random(0.5,1), p);
       }
       
     }  
  }
  if(!draw) {
    pg1.dispose();
    pg2.dispose(); //to save
  }
  
  pg2.endDraw();
  pg1.endDraw();
  
  if(draw) {
    image(pg1, 0, 0);
    image(pg2, 0, 0); // to draw
  }
}


void hatch_circle_center(float xc, float yc, float r, float angle, float density, float startAn, float endAn, PGraphics p) { // opposit order
  float startAngle = radians(angle);
  for(float i = startAn; i <endAn;i+=density) {
    angle = acos(i);
    p.beginShape();
    p.vertex(cos(startAngle+angle)*r + xc,sin(startAngle+angle)*r + yc);
    p.vertex(cos(startAngle-angle)*r +xc,sin(startAngle-angle)*r + yc);
    p.endShape();
  }
  strokeWeight(3);
}

void hatch_circle_center_r(
  float xc,
  float yc,
  float r,
  float angle,
  float density,
  float startAn,
  float endAn,
  PGraphics p) { // opposit order
  float startAngle = radians(angle);
  for(float i = startAn; i <endAn;i+=density) {
    angle = acos(i) + random(0.1, 0.5);
    p.beginShape();
    p.vertex(cos(startAngle+angle)*r + xc,sin(startAngle+angle)*r + yc);
    p.vertex(cos(startAngle-angle)*r +xc,sin(startAngle-angle)*r + yc);
    p.endShape();
  }
  strokeWeight(1.5);
}
