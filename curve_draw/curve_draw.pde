int thinAmount = 2; //2 //<>//
int pageWidth = 800;
int pageHeight = 800;
int[][] done = new int[pageWidth][pageHeight];
boolean paused = false;
PImage image2;

int[] brightnessLimits = new int[] {230, 180, 150, 120, 80, 40, 20}; //{230, 180, 150, 120, 80, 40, 20}
//int clickCount = 0;
int loopAmount = 600*20000; //600*20000;

int thinMin = 0; //0
int thinMax = 25; //25

float randBrightness;
float prevBrightness;
float brightnessThreshold = 40; //40
float distanceThreshold = 40; //30

void setup(){
  image2 = loadImage("adrea.jpg");
  size(800,800);
  background(255);
  //image(image2,0,0);
  noFill();
  noLoop();
}

// SETS COORDINATES AS DONE OR NOT BASED ON THINNING ALGORITHM void setDone(int x, int y) { //<>//
void setDone(int x, int y) {
  for(int i=x-(thinAmount/2); i<=x+(thinAmount/2); i++) { 
   for(int j=y-(thinAmount/2); j<=y+(thinAmount/2); j++) { 
     if(i>=0 && i<pageWidth && j>=0 && j<pageHeight) { 
       done[i][j]=1;
      }
    }
  }
}

boolean isDone(int x, int y){
  return done[x][y]==1;
}

void draw(){
  //draw3();
  for(int o = 0; o < 5; o++){
    distanceThreshold += 5;
    draw3();
  }
}


void draw3() {
  for(int clickCount = 0; clickCount < 6; clickCount++){
    println(clickCount);
    if (paused) return;
    int randX = int(random(pageWidth));
    int randY = int(random(pageHeight));
    int prevX = randX;
    int prevY = randY;
    stroke(20);
    beginShape() ;
    for (int i =0; i<loopAmount; i++) { 
      randX = int(random(pageWidth));
      randY = int(random(pageHeight));
      randBrightness = brightness(image2.pixels[randX+randY*width]);
      prevBrightness = brightness(image2.pixels[prevX+prevY*width]);
      
      thinAmount = int(map(randBrightness, 0, 255, thinMin, thinMax));
      //int lowerLimit = 0;
      int lowerLimit = (clickCount < brightnessLimits.length-1) ? brightnessLimits[clickCount+1] : 0;
      if (randBrightness <= brightnessLimits[clickCount] && randBrightness >= lowerLimit) {
        if (!isDone(randX, randY)) {
          if (abs(randBrightness-prevBrightness) < brightnessThreshold) {
            if (dist(randX,randY,prevX,prevY) < distanceThreshold) {
              println(clickCount);
              curveVertex(randX, randY);
              prevX = randX;
              prevY = randY;
              setDone(randX, randY);
            }
          }
        }
      }
    }
    endShape();
  }
  
}
