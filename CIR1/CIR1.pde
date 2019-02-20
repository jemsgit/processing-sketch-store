import processing.svg.*;
float r = 10;
float r_step = 20;
int count = 30;
float x;
float y;
int sign = 1;

void setup() {
  size(1220, 700);
  noLoop();
  background(255);
  beginRecord(SVG, "filename1.svg");
}

void draw() {
  noFill();
  for(int i = 0; i < count; i++){
        // Polar to Cartesian conversion
      float theta = random(PI);
      if(random(0,2) > 1) {
        sign = -1;
      } else {
        sign = 1;
      }
      x = r * cos(theta);
      arc(width/2, height/2, r, r, theta, sign * theta + PI);
    
      // Draw an ellipse at x,y
      r+= r_step;
  }
  endRecord();
}
