import processing.svg.*;
  
PGraphics pg1;
PGraphics pg2;
PGraphics pg3;

boolean draw = false;

void setup() {
  size(1000, 1000);
  if(draw) {
    pg1 = createGraphics(1000, 1000);
    pg2 = createGraphics(1000, 1000);
    pg3 = createGraphics(1000, 1000);
  } else {
    pg1 = createGraphics(1000, 1000, SVG, "out1.svg"); //to save
    pg2 = createGraphics(1000, 1000, SVG, "out2.svg"); //to save
    pg3 = createGraphics(1000, 1000, SVG, "out3.svg");
  }
  noLoop();
}

void draw() {
  pg1.beginDraw();
  pg1.noFill();
  pg1.background(255);
  pg1.stroke(255, 51, 187);
  hatch_circle_cut2(500, 500, 400, 60, 0.08, false, pg1);
  if(!draw) {
    pg1.dispose(); //to save
  }
  pg1.endDraw();
  if(draw) {
    image(pg1, 0, 0); // to draw
  }
  
  pg2.beginDraw();
  pg2.noFill();
  if(draw) {
    pg2.background(255, 1); // to draw
  } else {
    pg2.background(255); // to save
  }
  pg2.stroke(0, 115, 230);
  hatch_circle_cut2(500, 500, 400, -35, 0.15, false, pg2);
  
  if(!draw) {
    pg2.dispose(); //to save
  }
  
  pg2.endDraw();
  
  if(draw) {
    image(pg2, 0, 0); // to draw
  }
  
  
  
  pg3.beginDraw();
  pg3.noFill();
  if(draw) {
    pg3.background(255, 1); // to draw
  } else {
    pg3.background(255); // to save
  }
  pg3.stroke(0);
  hatch_circle_random(500, 500, 400, 15, 0.03, false, -0.3, 0.5, pg3);
  
  if(!draw) {
    pg3.dispose(); //to save
  }
  
  pg3.endDraw();
  
  if(draw) {
    image(pg3, 0, 0); // to draw
  }
}

void hatch_circle_cut2(float xc, float yc, float r, float angle, float density, boolean drawCirle, PGraphics p) {
  float startAngle = radians(angle);
  float prevAngle = -1;
  boolean opposit = false;
  for(float i = -1; i <1;i+=density) {
    angle = acos(i);
    p.line(cos(startAngle+angle)*r + xc,sin(startAngle+angle)*r + yc,cos(startAngle-angle)*r +xc,sin(startAngle-angle)*r + yc);
    if(prevAngle != -1) {
      if(opposit) {
        p.arc(xc, yc, r*2, r*2, startAngle-prevAngle, startAngle-angle);
      } else {
        p.arc(xc, yc, r*2, r*2, startAngle+angle, startAngle+prevAngle);
      }
    }
    prevAngle = angle;
    opposit = !opposit;
  }
  strokeWeight(3);
  if(drawCirle) {
    p.ellipse(xc,yc,r*2,r*2);
  }
}

void hatch_circle_random(float xc, float yc, float r, float angle, float density, boolean drawCirle, float start, float end, PGraphics p) {
  float startAngle = radians(angle);
  for(float i = -1; i <1;i+=density) {
    angle = acos(i) + random(start, end);
    p.line(cos(startAngle+angle)*r + xc,sin(startAngle+angle)*r + yc,cos(startAngle-angle)*r +xc,sin(startAngle-angle)*r + yc);
  }
  strokeWeight(3);
  if(drawCirle) {
    p.ellipse(xc,yc,r*2,r*2);
  }
}
