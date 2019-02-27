import processing.svg.*;
  
PGraphics pg1;
PGraphics pg2;

void setup() {
  size(900, 1051);
  //pg1 = createGraphics(900, 900);
  //pg2 = createGraphics(900, 900);
  
  pg1 = createGraphics(900, 900, SVG, "out1.svg"); //to save
  pg2 = createGraphics(900, 900, SVG, "out2.svg"); //to save
  noLoop();
}

void draw() {
  
  pg1.beginDraw();
  pg1.noFill();
  pg1.background(255);
  pg1.stroke(0);
  hatch_circle_cut2(300, 300, 300, 45, 0.05, false, pg1);
  pg1.dispose(); //to save
  pg1.endDraw();
  //image(pg1, 0, 0); // to draw
  
  pg2.beginDraw();
  pg2.noFill();
  pg2.background(255); // to save
  //pg2.background(255, 1); // to draw
  pg2.stroke(204, 102, 0);
  hatch_circle_cut2(300, 300, 300, -45, 0.09, false, pg2);
  pg2.dispose(); //to save
  pg2.endDraw();
  //image(pg2, 0, 0); // to draw
}

void hatch_circle_cut2(float xc, float yc, float r, float angle, float density, boolean drawCirle, PGraphics p) {
  float startAngle = radians(angle);
  float prevAngle = -1;
  boolean opposit = false;
  for(float i = -1; i <1;i+=density) {
    println('p');
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
  strokeWeight(1.5);
  if(drawCirle) {
    p.ellipse(xc,yc,r*2,r*2);
  }
}
