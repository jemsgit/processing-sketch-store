float rect_x_start = 50;
float rect_y_start = 50;
float rect_width = 200;
float rect_height = 250;
float hatch_x = rect_x_start;
float hatch_y = rect_y_start;
float angle = -45;
int inc_x = 20;
float inc_y = 20 * sin(angle)*-1;

void setup() {
  size(800,800);
  smooth();
  stroke(0);
  noFill();
  noLoop();
}

void draw() {
  background(255);
  hatch_rect_cut(rect_x_start, rect_y_start, rect_width, rect_height, 125, 20);
}

void hatch_rect(float rect_x_start, float rect_y_start, float rect_width, float rect_height, float ang, float inc, boolean drawRect) {
  ang = ang+180;
  float angle = radians(ang);
  float k = tan(angle);
  float hatch_x;
  float inc_x;
  float x_f;
  float y_f;
  stroke(0);
  if(ang == 270) {
    float x = rect_x_start + inc;
    while(x < rect_x_start + rect_width) {
      line(x, rect_y_start, x, rect_y_start + rect_height);
      x += inc;
    }
  } else if(ang == 180) {
    float y = rect_y_start + inc;
    while(y < rect_y_start + rect_height) {
      line(rect_x_start, y, rect_x_start+rect_width, y );
      y += inc;
    }
  } else if(ang > 270) {
    inc_x = inc;
    x_f = rect_x_start;
    hatch_x = rect_x_start;
    float x_edge = rect_x_start + rect_width;
    float y_edge = rect_y_start + rect_height;
    while(x_f < x_edge) {
      hatch_x+= inc_x;
      float x_h = hatch_x;
      float y_h = rect_y_start;
      float b = rect_y_start - k*x_h;
      if(x_h > x_edge) {
        x_h = x_edge;
        y_h = k*x_h + b;
        if(y_h > y_edge){
          break;
        }
      }
      x_f = rect_x_start;
      y_f = k*x_f + b;
      
      if(y_f > y_edge) {
        y_f = y_edge;
        x_f = (y_f - b)/k;
      }
       line(x_h, y_h, x_f, y_f);
    }
  } else {
    inc_x = inc;
    hatch_x = rect_x_start + rect_width;
    x_f = rect_x_start + rect_width;
    float x_edge = rect_x_start;
    float y_edge = rect_y_start + rect_height;
    while(x_f > x_edge) {
      hatch_x-= inc_x;
      float x_h = hatch_x;
      float y_h = rect_y_start;
      float b = rect_y_start - k*x_h;
      if(x_h < x_edge) {
        x_h = x_edge;
        y_h = k*x_h + b;
        if(y_h > y_edge){
          break;
        }
      }
      x_f = rect_x_start + rect_width;
      y_f = k*x_f + b;
      
      if(y_f > y_edge) {
        y_f = y_edge;
        x_f = (y_f - b)/k;
      }
       line(x_h, y_h, x_f, y_f);
    }
    
  }
    if(drawRect) {
      rect(rect_x_start, rect_y_start, rect_width, rect_height);
    }
}

void hatch_rect_cut(float rect_x_start, float rect_y_start, float rect_width, float rect_height, float ang, float inc) {
  ang = ang+180;
  float angle = radians(ang);
  float k = tan(angle);
  float hatch_x;
  float inc_x;
  float x_f;
  float y_f;
  stroke(0);
  boolean draw_border = true;
  if(ang == 270) {
    float x_prev = rect_x_start;
    float x = rect_x_start + inc;
    while(x < rect_x_start + rect_width) {
      line(x, rect_y_start, x, rect_y_start + rect_height);
      if(draw_border) {
        line(x_prev, rect_y_start, x, rect_y_start);
        x_prev = x;
        x += inc;
        if(x > rect_x_start + rect_width) {
          x = rect_x_start + rect_width;
        }
        line(x_prev, rect_y_start + rect_height, x, rect_y_start + rect_height);
        x_prev = x;
      } else {
        x += inc;
      }
      draw_border = !draw_border;
    }
  } else if(ang == 180) {
    float y_prev = rect_y_start;
    float y = rect_y_start + inc;
    while(y < rect_y_start + rect_height) {
      line(rect_x_start, y, rect_x_start+rect_width, y);
      if(draw_border) {
        println(y_prev);
        line(rect_x_start, y_prev, rect_x_start, y);
        y_prev = y;
        println(y_prev);
        y += inc;
        if(y > rect_y_start + rect_height) {
          y = rect_y_start + rect_height;
        }
        line(rect_x_start + rect_width, y_prev, rect_x_start + rect_width, y);
        y_prev = y;
      } else {
        y += inc;
      }
      draw_border = !draw_border;
    }
  } else if(ang > 270) {
    inc_x = inc;
    x_f = rect_x_start;
    hatch_x = rect_x_start;
    float x_edge = rect_x_start + rect_width;
    float y_edge = rect_y_start + rect_height;
    float x_prev = rect_x_start;
    float y_prev = rect_y_start;
    while(x_f < x_edge) {
      hatch_x+= inc_x;
      float x_h = hatch_x;
      float y_h = rect_y_start;
      float b = rect_y_start - k*x_h;
      if(x_h > x_edge) {
        x_h = x_edge;
        y_h = k*x_h + b;
        if(y_h > y_edge){
          break;
        }
      }
      x_f = rect_x_start;
      y_f = k*x_f + b;
      
      if(y_f > y_edge) {
        y_f = y_edge;
        x_f = (y_f - b)/k;
      }
      line(x_h, y_h, x_f, y_f);
      if(draw_border) {
        line(x_prev, y_prev, x_h, y_h);
        x_prev = x_f; 
        y_prev = y_f;
        draw_border = !draw_border;
      } else {
        line(x_prev, y_prev, x_f, y_f);
        x_prev = x_h; 
        y_prev = y_h;
        draw_border = !draw_border;
      }
    }
  } else {
    inc_x = inc;
    hatch_x = rect_x_start + rect_width;
    x_f = rect_x_start + rect_width;
    float x_edge = rect_x_start;
    float y_edge = rect_y_start + rect_height;
    float x_prev = rect_x_start + rect_width;
    float y_prev = rect_y_start;
    while(x_f > x_edge) {
      hatch_x-= inc_x;
      float x_h = hatch_x;
      float y_h = rect_y_start;
      float b = rect_y_start - k*x_h;
      if(x_h < x_edge) {
        x_h = x_edge;
        y_h = k*x_h + b;
        if(y_h > y_edge){
          break;
        }
      }
      x_f = rect_x_start + rect_width;
      y_f = k*x_f + b;
      
      if(y_f > y_edge) {
        y_f = y_edge;
        x_f = (y_f - b)/k;
      }
       line(x_h, y_h, x_f, y_f);
       if(draw_border) {
        line(x_prev, y_prev, x_h, y_h);
        x_prev = x_f; 
        y_prev = y_f;
        draw_border = !draw_border;
      } else {
        line(x_prev, y_prev, x_f, y_f);
        x_prev = x_h; 
        y_prev = y_h;
        draw_border = !draw_border;
      }
    }
    
  }
}
 
