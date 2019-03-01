float startAngle;
float density;
float radius;
void setup() {
  size(1200,1200);
  smooth();
  stroke(0);
  noFill();
  noLoop();
  radius = 500.0;
  density = 0.1;
}
void draw() {
  background(255);
  noFill();
  stroke(0);
  strokeWeight(1);
  hatch_circle_cut(radius, radius, radius, 45, 0.1, false);
}

void hatch_circle(float xc, float yc, float r, float angle, float density, boolean drawCirle) {
  float startAngle = radians(angle);
  for(float i = -1; i <1;i+=density) {
    angle = acos(i);
    line(cos(startAngle+angle)*r + xc,sin(startAngle+angle)*r + yc,cos(startAngle-angle)*r +xc,sin(startAngle-angle)*r + yc);
  }
  strokeWeight(1);
  if(drawCirle) {
    ellipse(xc,yc,r*2,r*2);
  }
}

void hatch_circle_random(float xc, float yc, float r, float angle, float density, boolean drawCirle, float start, float end) {
  float startAngle = radians(angle);
  for(float i = -1; i <1;i+=density) {
    angle = acos(i) + random(start, end);
    line(cos(startAngle+angle)*r + xc,sin(startAngle+angle)*r + yc,cos(startAngle-angle)*r +xc,sin(startAngle-angle)*r + yc);
  }
  strokeWeight(1.5);
  if(drawCirle) {
    ellipse(xc,yc,r*2,r*2);
  }
}

void hatch_circle_cut(float xc, float yc, float r, float angle, float density, boolean drawCirle) {
  float startAngle = radians(angle);
  float prevAngle = -1;
  boolean opposit = false;
  for(float i = -1; i <1;i+=density) {
    angle = acos(i);
    line(cos(startAngle+angle)*r + xc,sin(startAngle+angle)*r + yc,cos(startAngle-angle)*r +xc,sin(startAngle-angle)*r + yc);
    if(prevAngle != -1) {
      if(opposit) {
        arc(xc, yc, r*2, r*2, startAngle+angle + PI, startAngle+prevAngle + PI);
      } else {
        arc(xc, yc, r*2, r*2, startAngle+angle, startAngle+prevAngle);
      }
    }
    prevAngle = angle;
    opposit = !opposit;
}
  strokeWeight(1.5);
  if(drawCirle) {
    ellipse(xc,yc,r*2,r*2);
  }
}

void hatch_circle_cut2(float xc, float yc, float r, float angle, float density, boolean drawCirle) { // opposit order
  float startAngle = radians(angle);
  float prevAngle = -1;
  boolean opposit = false;
  for(float i = -1; i <1;i+=density) {
    angle = acos(i);
    line(cos(startAngle+angle)*r + xc,sin(startAngle+angle)*r + yc,cos(startAngle-angle)*r +xc,sin(startAngle-angle)*r + yc);
    if(prevAngle != -1) {
      if(opposit) {
        arc(xc, yc, r*2, r*2, startAngle-prevAngle, startAngle-angle);
      } else {
        arc(xc, yc, r*2, r*2, startAngle+angle, startAngle+prevAngle);
      }
    }
    prevAngle = angle;
    opposit = !opposit;
  }
  strokeWeight(1.5);
  if(drawCirle) {
    ellipse(xc,yc,r*2,r*2);
  }
}
