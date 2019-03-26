float time = 0;
float y_step = 2;
float x = 0;
float y = 20;
  
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
    beginShape();
    while (x < width) {
      offset = x;
      if(offset < 200) {
        offset = 400 - offset;
      }
      curveVertex(x, y + 100 * offset/100 * noise(x/200, time)-50 );
      x = x + 1;
      println(x);
    }
    println(y);
    endShape();
    y += y_step;
    time = time + 0.02;
  }
}
