import processing.svg.*;
void setup() {
  PGraphics p = beginRecord(SVG, "filename.svg");
  p.translate(width/2, height/2);
  size(1000, 1000, P3D);
  background(255);
  stroke(0, 50);
  fill(255, 200);
  
  translate(width/2, height/2, 0);
  
  for (float y = 0; y <= (height/2); y+=9) {
    noFill();
    beginShape();
    for (float x = -(width/4); x <= (width/4); x+=5) {
      drawVertex(x, y);
    }
    endShape();
  }
  endRecord();
}

void drawVertex(float x, float y) {
  if(random(10) > 4) {
    if(x > 0) {
      curveVertex(x, y + y*random(5) * 0.002);
    } else {
      curveVertex(x, y + y*random(5) * 0.002);
    }
  } else {
    curveVertex(x, y - y*random(5)* 0.002);
  }
}
