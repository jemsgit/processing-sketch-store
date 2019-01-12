import processing.svg.*;
float r = 0;
float theta = 0;
float el_r = 1;
float el_r_step = 0.5;
float r_step = 0.25;
int count = 16 * 66;
float pi2 = 6.28;
float x;
float y;

void setup() {
  size(720, 500);
  noLoop();
  background(255);
  beginRecord(SVG, "filename.svg");
}

void draw() {
  for(int i = 0; i < count; i++){
        // Polar to Cartesian conversion
      x = r * cos(theta);
      y = r * sin(theta);
    
      // Draw an ellipse at x,y
      noStroke();
      fill(0);
      // Adjust for center of window
      ellipse(x+width/2, y+height/2, el_r, el_r);
      stroke(0);
    
      // Increment the angle
      theta += 0.1;
      // Increment the radius
      print(theta);
      print("\r\n");
      if(theta >= pi2) {
        theta = 0;
        el_r += el_r_step;
      }
      r += r_step;
  }
  endRecord();
}
