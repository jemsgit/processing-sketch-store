import processing.svg.*;

PGraphics pg1;
PGraphics pg2;

boolean draw = false;
int MAGIC_NUMBER = 14;

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
  noFill();
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
  int cell_width = 60;
  int cell_height = 60;
  int count = 0;
  int y_count = 0;
  for(int i = 5; i < 1100 - (cell_height * 2); i+= cell_height){
    for(int j = 5; j < 1300 - (cell_width * 2); j+= cell_width){
      float delta_y = count * y_count * 3;
      if(count % 2 != 0) {
        drawColoredHehagon(j , i + 25 + delta_y, 30, count);
      } else {
         drawColoredHehagon(j, i + delta_y, 30, count);
      }
      count+=1;
    }
    count = 0;
    y_count+= 1;
  }
  if(!draw) {
    pg1.dispose(); //to save
    pg2.dispose(); //to save
    pg1.background(255);
    pg2.background(255);
  }
}

void drawColoredHehagon(float x_pos, float y_pos, int side_size, int count){
  int rand = int(random(0, 20)) + count;
  PGraphics pg = pg1;
  if(rand > MAGIC_NUMBER) {
    pg = pg2;
  }
  drawHexagon(x_pos, y_pos, side_size, pg);
}

void drawHexagon(float x_pos, float y_pos, int side_size, PGraphics pg) {
  pg.beginDraw();
  
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
  pg.endDraw();
  if(draw) {
    image(pg, 0, 0); // to draw
  }
  if(draw) {
    pg.background(255, 1); // to draw
  }
}
