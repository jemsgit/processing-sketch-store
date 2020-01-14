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
  int cell_width = 60;
  int cell_height = 60;
  int count = 0;
  int y_count = 0;
  float delta = 0;
  for(int i = 5; i < 1100 - (cell_height * 2); i+= cell_height){
    for(int j = 5; j < 1300 - (cell_width * 2); j+= cell_width){
      //float delta_y = pow(count, y_count/2)/10;
      float delta_y = count * y_count * 3;
      if(count % 2 != 0) {
        drawHexagon(j , i + 25 + delta_y, 30);
      } else {
         drawHexagon(j, i + delta_y, 30);
      }
      count+=1;
    }
    count = 0;
    y_count+= 1;
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
