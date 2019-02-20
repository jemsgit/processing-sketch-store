float startAngle;
float density;
float radius;
void setup() {
  size(800,800);
  smooth();
  stroke(0);
  noFill();
  startAngle  = PI/3;
  radius = 380;
  density = 0.1;
}
void draw() {
  background(255);
  startAngle = atan2(height/2-mouseY,width/2-mouseX);
  translate(width/2,height/2);
  noFill();
  stroke(0);
  strokeWeight(0.5);
  for(float i = -1; i <1;i+=density) {
    float angle = acos(i);
    line(cos(startAngle+angle)*radius,sin(startAngle+angle)*radius,cos(startAngle-angle)*radius,sin(startAngle-angle)*radius);
  }
  strokeWeight(1.5);
  ellipse(0,0,radius*2,radius*2);
  fill(220,220,0);
  stroke(255);
}
