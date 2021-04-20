import processing.svg.*;
void setup() {
  PGraphics p = beginRecord(SVG, "filename.svg");
  p.translate(width/2, height/2);
  size(1000, 1000, P3D);
  background(255);
  stroke(0, 50);
  fill(255, 200);
  
  float xstart = random(10);
  float ynoise = random(10);
  translate(width/2, height/2, 0);
  
  for (float y = -(height/7); y <= (height/7); y+=1) {
    ynoise += 0.015;
    float xnoise = xstart;
    noFill();
    beginShape();
    for (float x = -(width/7); x <= (width/7); x+=2) {
      xnoise += 0.03;
      drawVertex(x, y, noise(xnoise, ynoise));
    }
    endShape();
  }
  endRecord();
}

void drawVertex(float x, float y, float noiseFactor) {
  curveVertex(x * noiseFactor * 4, y * noiseFactor * 3);
}
