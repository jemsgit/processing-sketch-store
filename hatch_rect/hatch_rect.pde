float rect_x_start = 50;
float rect_y_start = 50;
float rect_width = 200;
float rect_height = 250;
float hatch_x = rect_x_start;
float hatch_y = rect_y_start;
float angle = -0.5;
int inc_x = 20;
float inc_y =20 * sin(angle)*-1;

void setup() {
  size(800,800);
  smooth();
  stroke(0);
  noFill();
  noLoop();
}

void draw() {
  background(255);
  float k = tan(angle);
  rect(rect_x_start, rect_y_start, rect_width, rect_height);
  while(hatch_x < rect_width + rect_x_start) {
    hatch_x+= inc_x;
    float b = rect_y_start - k*hatch_x;
    float x_f = rect_x_start;
    float y_f = k*x_f + b;
    line(hatch_x, rect_y_start, x_f, y_f);
  }
  
  hatch_y+= inc_y;
  while(hatch_y < rect_height + rect_y_start) {
    float b = hatch_y - k*hatch_x;
    float y_f = rect_y_start + rect_height;
    float x_f = (y_f - b) / k;
    if(x_f < rect_x_start) {
      x_f = rect_x_start;
      y_f = k*x_f + b;
    }
    line(rect_x_start+rect_width, hatch_y, x_f, y_f);
    hatch_y+= inc_y;
  }
  
}
