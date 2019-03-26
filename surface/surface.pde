float time = 0;
float y_step = 2;
float x = 0;
float y = 50;
  
void setup() {
  size(1000, 800);
  background(255);
  noFill();
  noLoop();
}

void draw() {

  while(y < 400){
    x = 0;
    float offset = x;
    float t_off = time;
    beginShape();
    while (x < width) {
      curveVertex(x, y + 100 * x/150 * noise((x+50)/100, time) );
      x = x + 1;
      println(x);
    }
    println(y);
    endShape();
    y += y_step;
    time = time + 0.02;
  }
}
