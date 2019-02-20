import processing.svg.*;
float r = 0;
float theta = 0;
float intal_theta = 0;
float r_step = 1.2;
int count = 300;
float pi2 = 6.28;
float x;
float y;

void setup() {
  size(720, 1051);
  noLoop();
  background(255);
  beginRecord(SVG, "filename.svg");
}

void draw() {
  noFill();
  beginShape();
  for(int i = 0; i < count; i++){
        // Polar to Cartesian conversion
      x = r * cos(theta);
      y = r * sin(theta);
      x+=random(10)*0.2;
      y+= random(10)*0.2;
    
      // Draw an ellipse at x,y
      noStroke();
      // Adjust for center of window
      curveVertex(x+width/2, y+height/2);
      stroke(0);
    
      // Increment the angle
      theta += 1.57;
      // Increment the radius
      if(theta >= pi2) {
        theta-= pi2;
        theta += 0.02;
      }
      print(theta);
      print("\r\n");
      r += r_step;
  }
  endShape();
  endRecord();
}
