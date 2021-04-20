import processing.svg.*;
import de.ixdhof.hershey.*;
PGraphics pg1;
HersheyFont hf;
PFont font_M;

boolean draw = false;
int delta;
PImage p1;
String imageName = "pika1.png";
int initialShift = 5;
String[] signsArray = new String[] {" ", "`", "-", ".", "'", "_", ":", ",", "\"", "=", "^", ";", "<", "+", "!", "*", "?", "/", "c", "L", "\\", "z", "r", "s", "7", "T", "i", "v", "J", "t", "C", "{", "3", "F", ")", "I", "l", "(", "x", "Z", "f", "Y", "5", "S", "2", "e", "a", "j", "o", "1", "4", "[", "n", "u", "y", "E", "]", "P", "6", "V", "9", "k", "X", "p", "K", "w", "G", "h", "q", "A", "U", "b", "O", "d", "8", "#", "H", "R", "D", "B", "0", "$", "m", "g", "M", "W", "&", "Q", "%", "N", "@"};
float[] darkArray = new float[] {0, 6.28, 8.37, 8.37, 10.04, 13.39, 16.74, 19.25, 20.92, 21.76, 21.76, 26.78, 27.62, 28.45, 28.87, 29.71, 33.47, 33.89, 33.89, 34.31, 34.31, 34.31, 34.73, 36.4, 36.82, 36.82, 37.66, 38.49, 38.91, 39.33, 39.75, 40.17, 41, 41, 41.84, 41.84, 41.84, 42.26, 42.26, 43.51, 43.51, 43.93, 44.35, 44.35, 45.19, 45.19, 46.44, 46.44, 46.44, 46.86, 46.86, 46.86, 46.86, 46.86, 47.28, 47.7, 48.54, 51.05, 52.3, 52.3, 53.56, 53.97, 56.07, 56.49, 56.9, 56.9, 57.32, 57.32, 57.32, 58.16, 58.16, 58.16, 58.58, 58.58, 61.51, 61.92, 61.92, 61.92, 63.18, 64.02, 66.11, 66.95, 67.36, 67.78, 69.04, 71.13, 72.38, 72.38, 75.31, 75.73, 100 };

void setup() {
  size(2000,2000);
  smooth();
  noFill();
  noLoop(); //<>//
  delta = 13;
  loadMainImage(imageName);
  if(draw) {
    pg1 = createGraphics(500, 500);
  } else {
    pg1 = createGraphics(500, 500, SVG, "out1.svg"); //to save
  }
  hf = new HersheyFont(this, "futural");
  beginRecord(SVG, "filename2.svg");
}

void loadMainImage(String imageName) {
  p1 = loadImage(imageName);
  p1.filter(GRAY);
}

String findClosesSign(float brightness) {
  float darkness = 255 - brightness;
  darkness = darkness/255 * 100;
  String value = null;
  float distance = Math.abs(darkArray[0] - darkness);
  int idx = 0;
  for(int c = 1; c < darkArray.length; c++){
      float cdistance = Math.abs(darkArray[c] - darkness);
      if(cdistance < distance){
          idx = c;
          distance = cdistance;
      }
  }
  value = signsArray[idx];
  return value;
}

void draw() {
  pg1.beginDraw(); //<>//
  pg1.noFill();
  pg1.background(255); //<>//
  int y = initialShift;
  int x = 0; //<>//
  hf.textSize(11);
  fill(0);
  while(y < p1.height) { //<>//
    x = initialShift;
    while(x < p1.width) {
      int loc = x + y*p1.width;
      float r = brightness(p1.pixels[loc]);
      println(r);
      String word = findClosesSign(r); //<>//
      if(word != null) {
        try{
          //text(word, x-delta, y+ delta);
          PShape ps = hf.getShape(word);
          shape(ps, x-delta, y+ delta);
        } catch(StringIndexOutOfBoundsException e) {
          println(word);
        }
      }
      //rect(x-delta, y-delta, delta, delta);
      //fill(int(r));
      x+= delta;
    }
    y += delta;
  }
  if(!draw) {
    pg1.dispose();
  }
  pg1.endDraw();
  endRecord();
}
