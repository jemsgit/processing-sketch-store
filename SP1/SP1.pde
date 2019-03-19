import processing.svg.*;
float r = 10;
float theta = 0;
float el_r = 5;
float el_r_step = 1.5;
float r_step = 0.6;
int count = 600;
float x;
float y;
color[] colors = {color(255, 0, 0), color(0, 153, 255), color(0, 0, 0)};
int color_selector = 0;

void setup() {
  size(1220, 1000);
  noLoop();
  background(255);
  beginRecord(SVG, "filename.svg");
}

void draw() {
  for(int i = 0; i < count; i++){
        // Polar to Cartesian conversion
      x = r * cos(theta);
      y = r * sin(theta);
      if(color_selector > 1) {
        color_selector = 0;
      }
      stroke(colors[color_selector]);
      color_selector++;
      if(theta > 3.90 && theta < 4.10 
        || theta > 0.80 && theta < 1.00){
        stroke(colors[2]);
        ellipse(x+width/2, y+height/2, el_r, el_r);
        ellipse(x+width/2, y+height/2, el_r-(el_r/4), el_r-(el_r/4));
        ellipse(x+width/2, y+height/2, el_r-(el_r/2), el_r-(el_r/2));
        ellipse(x+width/2, y+height/2, el_r-(el_r/1.5), el_r-(el_r/1.5));
      } else {
        ellipse(x+width/2, y+height/2, el_r, el_r);
        ellipse(x+width/2, y+height/2, el_r-(el_r/3), el_r-(el_r/3));
      }

      // Draw an ellipse at x,y
      // Adjust for center of window

      // Increment the angle
      theta += 0.2;
      // Increment the radius
      if(theta >= 6.28) {
        theta -= 6.28;
        el_r += el_r_step;
      }
      r += r_step;
  }
  endRecord();

}
