void setup() {
  size(1000, 1200);
  background(255);
  smooth();
  noLoop();
}

void draw() {
  drawCurveArray(80, 600);
  drawCurveArray(220, 500);
  drawCurveArray(340, 400);
  stroke(255, 0 , 0);
  drawCurveArray(480, 300);
  drawCurveArray(620, 200);
  drawCurveArray(760, 100);
}

void drawCurveArray(float init_x, float init_y) {
  drawCurve(init_x, init_y);
  drawCurve(init_x+20, init_y);
  drawCurve(init_x+40, init_y);
  drawCurve(init_x+60, init_y);
  drawCurve(init_x+ 80, init_y);
  drawCurve(init_x + 100, init_y);
  drawCurve(init_x + 120, init_y);
}

void drawCurve(float init_x, float init_y){
  noFill();
  strokeWeight(10);
  beginShape();
  vertex(init_x, random(30, init_y)); // the first control point
  vertex(init_x, init_y + 200);
  vertex(init_x + 100, init_y + 240);
  vertex(init_x + 100, random(int(init_y) + 320, 1200)); // the last point of curve
  endShape();
}
