import processing.svg.*;

PGraphics pg1;
PGraphics pg2;

boolean draw = true;

void setup() {
  size(1300,1300);
  smooth();
  if(draw) {
    pg1 = createGraphics(1300, 1300);
  }
  background(255);
  noFill();
  noLoop();  
}

void draw() {
  pg1.beginDraw();
  pg1.noFill();
  pg1.background(255);
  pg1.strokeWeight(1);
  pg1.stroke(0);
  int cell_width = 50;
  int cell_height = 50;
  int count = 0;
  for(int i = 5; i < 1300 - cell_height; i+= cell_height){
    for(int j = 5; j < 1300 - cell_width; j+= cell_width){
      if(count % 2 != 0) {
        drawHexagon(j, i + 25, 30);
      } else {
         drawHexagon(j, i, 30);
      }
      println(j);
      count+=1;
    }
    println(count);
    count = 0;
  }
}

void drawHexagon(float x_pos, float y_pos, int side_size) {
  float x_start = x_pos + side_size * sin(0.523599);
  float y_start = y_pos;
  float x_end = x_start + side_size;
  float y_end = y_pos;
  line(x_start, y_start, x_end, y_end);
  x_start = x_start + side_size;
  x_end = x_start + side_size * sin(0.523599);
  y_end = y_start + side_size * cos(0.523599);
  line(x_start, y_start, x_end, y_end);
  x_start = x_end;
  y_start = y_end;
  x_end = x_start - side_size * sin(0.523599);
  y_end = y_start + side_size * cos(0.523599);
  line(x_start, y_start, x_end, y_end);
  x_start = x_end;
  y_start = y_end;
  x_end = x_start - side_size;
  y_end = y_start;
  line(x_start, y_start, x_end, y_end);
  x_start = x_end;
  y_start = y_end;
  x_end = x_start - side_size * sin(0.523599);
  y_end = y_start - side_size * cos(0.523599);
  line(x_start, y_start, x_end, y_end);
  x_start = x_end;
  y_start = y_end;
  x_end = x_start + side_size * sin(0.523599);
  y_end = y_start - side_size * cos(0.523599);
  line(x_start, y_start, x_end, y_end);
}
