import processing.sound.*;
import processing.svg.*;

// Declare the processing sound variables 
SoundFile sample;
Amplitude rms;

PFont f;
int circlesCount = 6;
int initialRadius = 30;
int deltaRadius = 70;
ArrayList<Integer> circlesElementsCount = new ArrayList<Integer>();
ArrayList<Float> values = new ArrayList<Float>();
int allElementsCount = 0;
float allElementsLength = 0;
int deltaX = 3;
float deltaTime;
int i = 0;
float currentTime = 0;
// Declare a smooth factor
float smoothFactor = 1;
boolean drawed = false;
String title = "THE WHITE STRIPES";
String title2 = "LITLE ROOM";
void setup() {
  size(1200, 1000);
  background(255);

  f = createFont("OpenSans-Extrabold",70, true);
  textFont(f);
  for(int i = 0; i < circlesCount; i++){
    int radius = initialRadius + (deltaRadius * i);
    float circleLength = TWO_PI * radius;
    allElementsLength += circleLength;
    int elementsCount = Math.round(circleLength / deltaX);
    circlesElementsCount.add(elementsCount);
    println(elementsCount);
    allElementsCount += elementsCount;
  }
  print("all - ");
  println(allElementsCount);
  sample = new SoundFile(this, "oh3.mp3");
  println(sample.duration());
  float duration = sample.duration();
  deltaTime = duration/allElementsCount;
  rms = new Amplitude(this);
  rms.input(sample);
  //noLoop();
  //sample.play();
  stroke(0);
  fill(0);
  //sample.play();
  beginRecord(SVG, "filename.svg");
}

void draw() {
  if(false){
    float rmsScaled = rms.analyze() * (deltaRadius - 5);
    values.add(rmsScaled);
    println(values.size());
    background(255);
    fill(0,0,255);
    circle(width/2, 400, rmsScaled);
  } else {
    println(values.size());
    if(!drawed && true){
      //drawCircles(600, 400, values, allElementsCount);
      drawTitle(title, title2);
      endRecord();
    }
  }
}

void drawTitle(String title, String title2) {
  textAlign(CENTER,CENTER);
  text(title,width/2,650);
  text(title2,width/2,800);
}

void drawCircles(int x0, int y0, ArrayList<Float> values, int count){
  drawed = true;
  int delta = (int)Math.ceil(values.size()/(float)count);
  println("OldCount: ");
  println(count);
  println("OldDeltaX: ");
  println(deltaX);
  println("Delta: ");
  println(delta);
  count = (int)Math.ceil(values.size()/delta);
  println("NewCount: ");
  println(count);
  float fCount = (float)count;
  float fdeltaX = allElementsLength/fCount;
  allElementsLength = 0;
  allElementsCount = 0;
  ArrayList<Integer> newCirclesElementsCount = new ArrayList<Integer>();
  for(int i = 0; i < circlesCount; i++){
    int radius = initialRadius + (deltaRadius * i);
    float circleLength = TWO_PI * radius;
    allElementsLength += circleLength;
    int elementsCount = Math.round(circleLength / fdeltaX);
    newCirclesElementsCount.add(elementsCount);
    println(elementsCount);
    allElementsCount += elementsCount;
  }
  ArrayList<Float> newValues = new ArrayList<Float>();
  for(i = 0; i < count; i++){
      if(i*delta >= values.size()){
        break;
      }
      newValues.add(values.get(i*delta));
  }
  print("New values size: ");
  println(newValues.size());
  int position = 0;
  for(int j = 0; j < circlesCount; j++){
    drawCircle(x0, y0, initialRadius + j*deltaRadius, new ArrayList<Float>(newValues.subList(position, position + newCirclesElementsCount.get(j) - 1)));
    position = position + newCirclesElementsCount.get(j) - 1;
  }
}

void drawCircle(int x0, int y0, int r, ArrayList<Float> values) {
  int valuesCount = values.size();
  float deltaAngle = TWO_PI/valuesCount;
  for(int i = 0; i < valuesCount; i++){
     float x1 = x0 + r * cos(i * deltaAngle);
     float y1 = y0 + r * sin(i * deltaAngle);
     float x2 = x0 + (r + values.get(i)) * cos(i * deltaAngle);
     float y2 = y0 + (r + values.get(i)) * sin(i * deltaAngle);
     line(x1, y1, x2, y2);
  }
}
