import processing.svg.*;
  
PGraphics pg1;
PGraphics pg2;

void setup() {
  size(720, 1051);
  pg1 = createGraphics(200, 200);
  pg2 = createGraphics(200, 200);
  
  //pg1 = createGraphics(200, 200, SVG, "out1.svg"); to save
  //pg2 = createGraphics(200, 200, SVG, "out2.svg"); to save
  noLoop();
}

void draw() {
  
  pg1.beginDraw();
  pg1.noFill();
  pg1.background(255);
  pg1.stroke(100);
  pg1.rect(30, 20, 55, 55);
  //pg1.dispose(); to save
  pg1.endDraw();
  image(pg1, 0, 0); // to draw
  
  pg2.beginDraw();
  pg2.noFill();
  //pg2.background(255); // to save
  pg2.background(255, 1); // to draw
  pg2.stroke(204, 102, 0);
  pg2.rect(40, 30, 75, 65);
  //pg2.dispose(); to save
  pg2.endDraw();
  image(pg2, 0, 0); // to draw
}
