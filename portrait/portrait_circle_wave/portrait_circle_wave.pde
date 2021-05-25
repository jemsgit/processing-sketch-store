import controlP5.*;
import processing.svg.*;

ControlP5 gui;

PShape s;
PShape liner;

PImage p1;
PImage p2;

int ystep = 160;
int ymult = 6;
int xstep = 3;
float xsmooth = 128.0;

int imageScaleUp = 1;

float r = 0.0;
float a = 0.0;
int strokeWidth = 1;

float startx, starty, z;

int b, oldb;
int maxB = 255;
int minB = 0;

boolean isRunning = true;
boolean isRecording = false;
boolean needsReload = true;

boolean invert = false;

boolean connectEnds = false;

String imageName = "lemmy2.jpg";

void setup() {
  size(100, 100);
  //surface.setResizable(true);
  loadMainImage(imageName);
  createSecondaryImage();

  gui = new ControlP5(this);
  gui.addSlider("sldLines").setSize(130, 30).setCaptionLabel("Number of Lines").setPosition(10, 20).setRange(10, 200).setValue(120).setColorCaptionLabel(color(0));
  gui.getController("sldLines").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addToggle("tglInvert").setCaptionLabel("Invert Colors").setPosition(10, 80).setValue(false).setMode(ControlP5.SWITCH).setColorCaptionLabel(color(0));
  gui.getController("tglInvert").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("sldAmplitude").setSize(130, 30).setCaptionLabel("Squiggle Strength").setPosition(10, 140).setRange(0, 20).setValue(13).setColorCaptionLabel(color(0));
  gui.getController("sldAmplitude").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("sldXSpacing").setSize(130, 30).setCaptionLabel("Detail").setPosition(10, 200).setRange(1, 30).setValue(28).setColorCaptionLabel(color(0));
  gui.getController("sldXSpacing").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("sldXFrequency").setSize(130, 30).setCaptionLabel("Frequency").setPosition(10, 260).setRange(5.0, 200.0).setValue(128.0).setColorCaptionLabel(color(0));
  gui.getController("sldXFrequency").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("sldImgScale").setSize(130, 30).setCaptionLabel("Resolution Scale").setPosition(10, 320).setRange(1, 3).setValue(3).setColorCaptionLabel(color(0));
  gui.getController("sldImgScale").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("lineWidth").setSize(130, 30).setCaptionLabel("Line Width").setPosition(10, 380).setRange(1, 10).setValue(5).setColorCaptionLabel(color(0));
  gui.getController("lineWidth").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("minBrightness").setSize(130, 30).setCaptionLabel("Black Point").setPosition(10, 440).setRange(0, 255).setValue(0).setColorCaptionLabel(color(0));
  gui.getController("minBrightness").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("maxBrightness").setSize(130, 30).setCaptionLabel("White Point").setPosition(10, 500).setRange(0, 255).setValue(255).setColorCaptionLabel(color(0));
  gui.getController("maxBrightness").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  // added: .setTriggerEvent(Bang.RELEASE)
  // now you don't have to click 's' to save. save button work fine now. 
  gui.addBang("bangLoad").setSize(130, 30).setTriggerEvent(Bang.RELEASE).setCaptionLabel("Load image").setPosition(10, 600).setColorCaptionLabel(color(255));
  gui.getController("bangLoad").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  gui.addBang("bangSave").setSize(130, 30).setCaptionLabel("Save SVG").setPosition(10, 660).setColorCaptionLabel(color(255));
  gui.getController("bangSave").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  // add 'default' button
  gui.addBang("bangDefault").setSize(130, 30).setCaptionLabel("Default").setPosition(10, 720).setColorCaptionLabel(color(255));
  gui.getController("bangDefault").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  //// add 'fit' button. fit image to window size 
  //gui.addBang("bangFit").setSize(65, 30).setCaptionLabel("Fit").setPosition(10, 780).setColorCaptionLabel(color(255));
  //gui.getController("bangFit").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  //// add 'full' button. load orig image size
  //gui.addBang("bangFull").setSize(65, 30).setCaptionLabel("Full").setPosition(10 + 66, 780).setColorCaptionLabel(color(255));
  //gui.getController("bangFull").getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  smooth();
  background(255);
  shapeMode(CORNER);
}

void loadMainImage(String inImageName) {
  //if (isInit) { return; }
  println("loadMainImage");
  //isInit = true;
  p1 = loadImage(inImageName);

  int tempheight = p1.height;
  if (tempheight < 720 + 120)
    tempheight = 720 + 120;

  surface.setSize(p1.width + 150, tempheight);

  // filter image
  p1.filter(GRAY);
  p1.filter(BLUR, 2);
  if (invert) {
    p1.filter(INVERT);
  }

  needsReload = true;
  redrawImage();
}

void createSecondaryImage() {
  p2 = createImage(p1.width*imageScaleUp, p1.height*imageScaleUp, ALPHA);
  p2.copy(p1, 0, 0, p1.width, p1.height, 0, 0, p1.width*imageScaleUp, p1.height*imageScaleUp);
  image(p2, 0 ,0);
}

void draw() {
  if (isRunning) {

    if (isRecording) {
      // save to file
      // was: beginRecord(SVG, "squiggleImage_" + millis() + ".svg");
      String[] p = splitTokens(imageName, "."); // split by point to know path without suffix
      // save to dir where is opening file
      String savePath = p[p.length - 2] + "_" + day() + hour() + minute() +  second() + ".svg";           
      println(savePath);
      beginRecord(SVG, savePath);
    }
    createPic();
    if (isRecording) {
      endRecord();
    }
    isRunning = false;
    isRecording = false;
    createPic();
  }
}

void bangLoad() {  
  println(":::LOAD JPG, GIF or PNG FILE:::");

  selectInput("Select an image file to open:", "fileSelected");  // Opens file chooser
} //End Load File

void sldLines(int value) {
  ystep = value;
  needsReload = false;
  redrawImage();
}

void sldAmplitude(int value) {
  ymult = value;
  needsReload = false;
  redrawImage();
}

void sldXSpacing(int value) {
  xstep = 31-value;
  needsReload = false;
  redrawImage();
}

void lineWidth(int value) {
  strokeWidth = value;
  redrawImage();
}

void maxBrightness(int value) {
  maxB = value;
  redrawImage();
}

void minBrightness(int value) {
  minB = value;
  redrawImage();
}

void bangSave() {
  isRecording = true;
  isRunning = true;
  redraw();
}

void sldXFrequency(float value) {
  xsmooth = 257.0 - value;
  needsReload = false;
  redrawImage();
}

void sldImgScale(int value) {
  imageScaleUp = value;
  needsReload = true;
  redrawImage();
}

void tglInvert(boolean value) {
  invert = value;
  needsReload = true;
  redrawImage();
}

void redrawImage() {
  isRunning = true;
  isRecording = false;
}

void keyPressed() {
  if (key == ' ') {
    // nothing here
  } else if (key == 's') { // save
    isRecording = true;
    isRunning = true;
    redraw();
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the cancel selected.");
  } else {
    String loadPath = selection.getAbsolutePath();

    // If a file was selected, print path to file 
    println("Selected file: " + loadPath); 

    String[] p = splitTokens(loadPath, ".");
    boolean fileOK = false;

    if ( p[p.length - 1].equals("GIF"))
      fileOK = true;
    if ( p[p.length - 1].equals("gif"))
      fileOK = true;      
    if ( p[p.length - 1].equals("JPG"))
      fileOK = true;
    if ( p[p.length - 1].equals("jpg"))
      fileOK = true;   
    if ( p[p.length - 1].equals("TGA"))
      fileOK = true;
    if ( p[p.length - 1].equals("tga"))
      fileOK = true;   
    if ( p[p.length - 1].equals("PNG"))
      fileOK = true;
    if ( p[p.length - 1].equals("png"))
      fileOK = true;   

    if (fileOK) {
      println("File type OK."); 
      imageName = loadPath;
      //isInit = false;
      loadMainImage(imageName);
      createSecondaryImage();
      redrawImage();
    } else {
      // Can't load file
      println("ERROR: BAD FILE TYPE");
    }
  }
}

void bangDefault() {
  gui.getController("sldLines").setValue(120);
  gui.getController("tglInvert").setValue(0);
  gui.getController("sldAmplitude").setValue(13);
  gui.getController("sldXSpacing").setValue(28);
  gui.getController("sldXFrequency").setValue(128);
  gui.getController("sldImgScale").setValue(1);
  gui.getController("lineWidth").setValue(5);
  gui.getController("minBrightness").setValue(0);
  gui.getController("maxBrightness").setValue(255);
}

void createPic() {
  println("create");
  if (needsReload) {
    loadMainImage(imageName);
    createSecondaryImage();
    needsReload = false;
  }

  stroke(0);
  noFill();
  strokeWeight(strokeWidth);
  float start_x = width/2;
  float start_y = height/2;
  float x = start_x;
  float y = start_y;

  if (!isRecording)
    background(255);

  float scaleFactor = 1.0/imageScaleUp;

  strokeWeight(strokeWidth * scaleFactor);
 
  float lastX;
  float angle_step = 0.01;
  float theta = 0;
  float r = 10;
  angle_step = asin(2/r)*2;
  int i = 0;
  float r_step = 0.01;
  r_step = 16 / (TWO_PI / angle_step);
  lastX = r * cos(theta) + start_x;
  x = lastX;
  beginShape();
  x = r * cos(theta) + start_x;
  y = r * sin(theta) + start_y;
  curveVertex(x, y);
  boolean top = true;
  while(i < 50) {
    b = (int)alpha(p2.get((int)x, (int)y));
    b=255-b;
    minB = 1;
    maxB = 8;
    z = int(map(b, 0, 255, minB, maxB));;        // Brightness trimmed to range.
    if(top){
      x = (r + z) * cos(theta) + start_x;
      y = (r + z) * sin(theta) + start_y;
    } else {
      x = (r - z) * cos(theta) + start_x;
      y = (r - z) * sin(theta) + start_y;
    }
    curveVertex(x, y);
    theta+=angle_step;
    r+=r_step;
    top = !top;
    if(theta >= 6.28) {
      theta = 0;
      angle_step = asin(2/r)*2;
      r_step = 16 / (TWO_PI / angle_step);
      i++;
    }
    
  }
  endShape();
}

void createPic2() {

  if (needsReload) {
    loadMainImage(imageName);
    createSecondaryImage();
    needsReload = false;
  }

  stroke(0);
  noFill();
  strokeWeight(strokeWidth);



  if (!isRecording)
    background(255);

  float scaleFactor = 1.0/imageScaleUp;
  float xOffset = isRecording ? 0 : 150;
  float angle_step = 0.001;
  float start_x = width/2;
  float start_y = height/2;
  
  float r = 10;
  float r_step = 0.01;
  float theta = 0;
  
  beginShape();
  float x = r * cos(theta) + start_x;
  float y = r * sin(theta) + start_y;
  
  float deltaPhase;
  float deltaX;
  float deltaAmpl;

  /*
   The minimum phase increment should give about 40 vertices minimum
   across x. 40 vertices -> 10 * 2 pi. 
   */
  float minPhaseIncr = 10 * TWO_PI / (TWO_PI * r / angle_step);

  /*
    Maximum phase increment (frequency cap) is based on line thickness and x step size.
   
   A full period of oscillation needn't be less than 
   2 * strokeWidth in total width.
   
   The maximum number of full cycles that should be permitted in a 
   horizontal distance of xstep should be:
   N = total width/width per cycle =  xstep / (2 * strokeWidth)
   
   The maximum phase increment in distance xstep should then be:
   
   maxPhaseIncr = 2 Pi * N = 2 * Pi *  xstep / (2 * strokeWidth) 
   = 2Pi *  xstep / strokeWidth
   
   We do not need to include the scaling factors, since
   both the step size and stroke width are scaled the same way.
   */


  float maxPhaseIncr =  TWO_PI * angle_step / strokeWidth;

  strokeWeight(strokeWidth * scaleFactor);
  
  beginShape();

  float scaledYstep = p2.height/ystep;
  float phase = 0.0;
  float lastPhase = 0; // accumulated phase at previous vertex
  float lastAmpl = 0; // amplitude at previous vertex
  float r2;
  int i = 0;
  curveVertex(x,y);
  float lastX = x;
  float lastY = y;
  theta+=angle_step;
  r+=r_step;
  x = r * cos(theta) + start_x;
  y = r * sin(theta) + start_y;

  while (i< 50) {
    a = 0.0;
    b = (int)alpha(p2.get((int)x, (int)y));
    b=255-b;
    minB = 1;
    maxB = 8;
    z = int(map(b, 0, 255, minB, maxB));        // Brightness trimmed to range.
    r2 = z/ystep*ymult;
    float df = z/xsmooth;
    if (df < minPhaseIncr)
      df = minPhaseIncr;

    /*
     Enforce a maximum phase increment -- a frequency cap -- to prevent 
     unnecessary plotting time. Once the frequency is so high that the line widths
     of neighboring crests overlap, there is no added benefit to having higher
     frequency; it's just wasting memory (and ink + time, if plotting).
     */

    if (df > maxPhaseIncr)
      df = maxPhaseIncr;
    phase += df;  // xsmooth: Frequency

    deltaX = sqrt(sq(x - lastX) + sq(y -lastY)); // Distance between image sample location x and previous vertex

    deltaAmpl = r2 - lastAmpl;

    deltaPhase = phase - lastPhase; // Change in phase since last *vertex*
      // (Vertices do not fall along the x "grid", but where they need to.)
      
    if (deltaPhase > HALF_PI) // Only add vertices if true.
        {
          /* 
           Linearly interpolate phase and amplitude since last vertex added.
           This treats the frequency as constant
           between subsequent x-samples of the source image.
           */

          int vertexCount = floor( deltaPhase / HALF_PI); //  Add this many vertices

          float integerPart = ((vertexCount * HALF_PI) / deltaPhase);
          // "Integer" fraction (in terms of pi/2 phase segments) of deltaX.

          float deltaX_truncate = deltaX * integerPart;
          // deltaX_truncate: "Integer" part (in terms of pi/2 segments) of deltaX.

          float xPerVertex =  deltaX_truncate / vertexCount;
          float amplPerVertex = (integerPart * deltaAmpl) / vertexCount;
          float new_theta = theta - angle_step;
          // Add the vertices:
          float delta_angle = asin((xPerVertex/2)/r);
          for (int j = 0; j < vertexCount; j = j+1) {
            lastPhase = lastPhase + HALF_PI;
            lastAmpl = lastAmpl + amplPerVertex;
            new_theta = theta + delta_angle;
            lastX = (r+cos(lastPhase)*lastAmpl) * cos(new_theta) + start_x;
            lastY = (r+sin(lastPhase)*lastAmpl) * sin(new_theta) + start_y;
            curveVertex(lastX, lastY);
          }
        }
    if(theta >= TWO_PI) {
      theta =0;
      i++;
    }
  }
  
  endShape();

  
  };
