import processing.svg.*;
float r = 0;
float theta = 0;
float intal_theta = 0;
float r_step = 0.05;
int count = 16 * 660;
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
  noFill();
  beginShape();
  for(int i = 0; i < count; i++){
        // Polar to Cartesian conversion
      x = r * cos(theta);
      y = r * sin(theta);
      //x+=random(10)*0.2;
      //y+= random(10)*0.2;
    
      // Draw an ellipse at x,y
      noStroke();
      // Adjust for center of window
      curveVertex(x+width/2, y+height/2);
      stroke(0);
    
      // Increment the angle
      theta += 1;
      // Increment the radius
      print(theta);
      print("\r\n");
      if(theta >= pi2) {
        intal_theta+= 0.1;
        theta = intal_theta;
      }
      r += r_step;
  }
  endShape();
  endRecord();
}
