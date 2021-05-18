void setup() {
  size(1400, 1200);
  background(255);
  smooth();
  noLoop();
}

void draw() {
  drawCurveArray(80, 100);
  drawCurveArray(400, 140);
  drawCurveArray(720, 180);
  drawCurveArray(80, 700);
  drawCurveArray(400, 740);
  drawCurveArray(720, 780);
  stroke(255, 0 , 0);
  drawCurveReverseArray(300, 400);
  drawCurveReverseArray(620, 440);
  drawCurveReverseArray(940, 480);
  drawCurveReverseArray(300, 1000);
  drawCurveReverseArray(620, 1040);
  drawCurveReverseArray(9400, 1080);
  //
  //drawCurveArray(480, 300);
  //drawCurveArray(620, 200);
  //drawCurveArray(760, 100);
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

void drawCurveReverseArray(float init_x, float init_y) {
  drawCurveReverse(init_x, init_y);
  drawCurveReverse(init_x+20, init_y);
  drawCurveReverse(init_x+40, init_y);
  drawCurveReverse(init_x+60, init_y);
  drawCurveReverse(init_x+ 80, init_y);
  drawCurveReverse(init_x + 100, init_y);
  drawCurveReverse(init_x + 120, init_y);
}

void drawCurve(float init_x, float init_y){
  noFill();
  strokeWeight(10);
  beginShape();
  vertex(init_x, init_y); // the first control point
  vertex(init_x+60, init_y);
  vertex(init_x + 120, init_y + 80);
  vertex(init_x + 120, init_y + 200);
  vertex(init_x + 60, init_y + 280);
  //vertex(init_x, init_y + 280);
  //vertex(init_x - 60, init_y + 360);
  //vertex(init_x - 60, random(int(init_y) + 360, int(init_y) + 550));
  endShape();
}

void drawCurveReverse(float init_x, float init_y){
  noFill();
  strokeWeight(10);
  beginShape();
  vertex(init_x, init_y); // the first control point
  vertex(init_x - 60, init_y);
  vertex(init_x - 120, init_y + 80);
  vertex(init_x - 120, init_y + 200);
  vertex(init_x - 50, init_y + 280);
  //vertex(init_x, init_y + 280);
  //vertex(init_x + 60, init_y + 360);
  //vertex(init_x + 60, random(int(init_y) + 360, int(init_y) + 550));
  endShape();
}
