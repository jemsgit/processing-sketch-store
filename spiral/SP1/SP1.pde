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

PGraphics pg1;
PGraphics pg2;
PGraphics pg3;

boolean draw = false;

void setup() {
  size(1220, 1000);
  noLoop();
  background(255);
  if(draw) {
    pg1 = createGraphics(1220, 1000);
    pg2 = createGraphics(1220, 1000);
    pg3 = createGraphics(1220, 1000);
  } else {
    pg1 = createGraphics(1220, 1000, SVG, "out1.svg"); //to save
    pg2 = createGraphics(1220, 1000, SVG, "out2.svg"); //to save
    pg3 = createGraphics(1220, 1000, SVG, "out3.svg"); //to save
  }
}

void draw() {
  pg1.beginDraw();
  pg1.noFill();
  pg1.background(255);
  pg2.beginDraw();
  pg2.noFill();
  pg3.beginDraw();
  pg3.noFill();
  if(draw) {
    pg2.background(255, 1);
    pg3.background(255, 1);
  } else {
    pg2.background(255);
    pg3.background(255);
  }
  pg1.strokeWeight(1);
  pg2.strokeWeight(1);
  pg3.strokeWeight(1);
  
  pg1.stroke(colors[0]);
  pg2.stroke(colors[1]);
  pg3.stroke(colors[2]);
  PGraphics p = pg1;
  for(int i = 0; i < count; i++){
        // Polar to Cartesian conversion
      x = r * cos(theta);
      y = r * sin(theta);
      if(color_selector > 1) {
        color_selector = 0;
        p = pg1;
      }
      if(color_selector == 1) {
        p = pg2;
      }
      if(color_selector == 0) {
        p = pg1;
      }
      color_selector++;
      if(theta > 3.90 && theta < 4.10 
        || theta > 0.80 && theta < 1.00){
        p = pg3;
        p.ellipse(x+width/2, y+height/2, el_r, el_r);
        p.ellipse(x+width/2, y+height/2, el_r-(el_r/4), el_r-(el_r/4));
        p.ellipse(x+width/2, y+height/2, el_r-(el_r/2), el_r-(el_r/2));
        p.ellipse(x+width/2, y+height/2, el_r-(el_r/1.5), el_r-(el_r/1.5));
      } else {
        p.ellipse(x+width/2, y+height/2, el_r, el_r);
        p.ellipse(x+width/2, y+height/2, el_r-(el_r/3), el_r-(el_r/3));
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
  if(!draw) {
    pg1.dispose();
    pg2.dispose(); //to save
    pg3.dispose();
  }
  
  pg2.endDraw();
  pg1.endDraw();
  pg3.endDraw();
  
  if(draw) {
    image(pg1, 0, 0);
    image(pg3, 0, 0);
    image(pg2, 0, 0); // to draw
  }

}
