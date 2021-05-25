import processing.svg.*;
float startAngle;
float density;
float radius;
color[] colors = {color(255, 0, 0), color(0, 153, 255)};
int[] angels = {-45, 0, 30, 45, 60, 90};
PGraphics pg1;
PGraphics pg2;

boolean draw = true;

void setup() {
  size(1300,1300);
  smooth();
  if(draw) {
    pg1 = createGraphics(1300, 1300);
    pg2 = createGraphics(1300, 1300);
  } else {
    pg1 = createGraphics(1300, 1300, SVG, "out1.svg"); //to save
    pg2 = createGraphics(1300, 1300, SVG, "out2.svg"); //to save
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
  int x_d = 120;
  int y_d = 120;
  int x_count = 10;
  int y_count = 10;
  int start_angle = -90;
  int finish_angle = 90;
  float delta = (finish_angle - start_angle) / x_count;
  float right_edge = 1;
  float edge_delta = 2.0 / y_count;
  for(int i = 0; i< x_count; i++) {
    
    float angle = start_angle;
     for(int j = 0; j< y_count; j++) {
         color c;
         c = colors[1];
         pg1.stroke(c);
         hatch_circle_center((i+1)*x_d, (j+1)*y_d, radius, angle, 0.13, -1, right_edge, pg1);
         c = colors[0];
         pg2.stroke(c);
         hatch_circle_center((i+1)*x_d, (j+1)*y_d, radius, angle+90, 0.13, right_edge, 1, pg2);
         angle += delta;
     }
     right_edge -= edge_delta;
     
     
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
