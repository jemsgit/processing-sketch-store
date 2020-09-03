import processing.svg.*;

PGraphics pg1;
PGraphics pg2;

boolean draw = true;
int MAGIC_NUMBER = 17;

void setup() {
  size(1300,1300);
  smooth();
    if(draw) {
    pg1 = createGraphics(1300, 1300);
    pg2 = createGraphics(1300, 1300);
  } else {
    pg1 = createGraphics(1300, 1300, SVG, "out1.svg"); //to save
    pg2 = createGraphics(1300, 1300, SVG, "out2.svg"); //to save
  }
  background(255);
  noLoop();  
}

void draw() {
  pg1.beginDraw();
  pg1.noFill();
  pg1.background(255);
  pg1.stroke(255, 51, 187);
  pg1.strokeWeight(2);

  pg2.beginDraw();
  pg2.noFill();
  pg2.stroke(0, 115, 230);
  pg2.strokeWeight(2);
  drawDiagonal(20, 20, 30);
  drawDiagonal(20, 120, 30);
  drawDiagonal(20, 220, 30);
  drawDiagonal(20, 320, 30);
  
  drawDiagonal(20, 550, 40);
  drawDiagonal(20, 650, 40);
  
  drawDiagonal(330, 20, 30);
  drawDiagonal(500, 20, 30);
  drawDiagonal(800, 20, 40);

  if(!draw) {
    pg1.endDraw();
    pg2.endDraw();
    pg1.dispose(); //to save
    pg2.dispose(); //to save
    //pg1.background(255);
    //pg2.background(255);
  }
}

void drawColoredHehagon(float x_pos, float y_pos, int side_size, int count){
  int rand = int(random(0, 20));
  PGraphics pg = pg1;
  if(rand > 10) {
    pg = pg2;
  }
  drawHexagon(x_pos, y_pos, side_size, pg, random(0,1) > 0.5);
}

void drawDiagonal(float x, float y, int cell_width){
  for(int i = 0; i < 15; i++){
      if(x < width && y < height){
       drawColoredHehagon(x, y, cell_width, i);
      }
     if(i > 6) {
       cell_width -= 3;
     } else {
       cell_width += 3;
     }
     x += 80;
     y += 50;
  }
}

void drawHexagon(float x_pos, float y_pos, int side_size, PGraphics pg, boolean recourcive) {
  if(draw){
    pg.beginDraw();
  }
  float x_start = x_pos + side_size * sin(0.523599);
  float y_start = y_pos;
  float x_end = x_start + side_size;
  float y_end = y_pos;
  pg.line(x_start, y_start, x_end, y_end);
  x_start = x_start + side_size;
  x_end = x_start + side_size * sin(0.523599);
  y_end = y_start + side_size * cos(0.523599);
  pg.line(x_start, y_start, x_end, y_end);
  x_start = x_end;
  y_start = y_end;
  x_end = x_start - side_size * sin(0.523599);
  y_end = y_start + side_size * cos(0.523599);
  pg.line(x_start, y_start, x_end, y_end);
  x_start = x_end;
  y_start = y_end;
  x_end = x_start - side_size;
  y_end = y_start;
  pg.line(x_start, y_start, x_end, y_end);
  x_start = x_end;
  y_start = y_end;
  x_end = x_start - side_size * sin(0.523599);
  y_end = y_start - side_size * cos(0.523599);
  pg.line(x_start, y_start, x_end, y_end);
  x_start = x_end;
  y_start = y_end;
  x_end = x_start + side_size * sin(0.523599);
  y_end = y_start - side_size * cos(0.523599);
  pg.line(x_start, y_start, x_end, y_end);

  if(draw) {
    pg.endDraw();
    image(pg, 0, 0); // to draw
  }
  if(draw) {
    pg.background(255, 1); // to draw
  }
  
  if(recourcive && side_size > 10) {
    drawHexagon(x_pos + 5, y_pos + 4.5, side_size - 5, pg, recourcive);
  }
}
