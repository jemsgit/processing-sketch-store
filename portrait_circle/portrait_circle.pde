import controlP5.*;
import processing.svg.*;

ControlP5 gui;

PImage p1;
PImage p2;

int cirlceCount = 20;
float delta_dist = 2.0;
int imageScaleUp = 1;

int strokeWidth = 1;
float z;

int maxB = 20;
int minB = 1;

boolean isRunning = true;
boolean isRecording = false;
boolean needsReload = true;

boolean invert = false;

String imageName = "lemmy2.jpg";

void setup() {
  size(100, 100);
  //surface.setResizable(true);
  loadMainImage(imageName);
  createSecondaryImage();

  gui = new ControlP5(this);
  
  gui.addToggle("tglInvert").setCaptionLabel("Invert Colors").setPosition(10, 80).setValue(false).setMode(ControlP5.SWITCH).setColorCaptionLabel(color(0));
  gui.getController("tglInvert").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("sldXSpacing").setSize(130, 30).setCaptionLabel("Detail").setPosition(10, 200).setRange(0.2, 5).setValue(2.0).setColorCaptionLabel(color(0));
  gui.getController("sldXSpacing").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("circleCountSet").setSize(130, 30).setCaptionLabel("Number of circles").setPosition(10, 260).setRange(10, 100).setValue(50).setColorCaptionLabel(color(0));
  gui.getController("circleCountSet").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("sldImgScale").setSize(130, 30).setCaptionLabel("Resolution Scale").setPosition(10, 320).setRange(1, 3).setValue(1).setColorCaptionLabel(color(0));
  gui.getController("sldImgScale").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("lineWidth").setSize(130, 30).setCaptionLabel("Line Width").setPosition(10, 380).setRange(1, 10).setValue(5).setColorCaptionLabel(color(0));
  gui.getController("lineWidth").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("minBrightness").setSize(130, 30).setCaptionLabel("Black Point").setPosition(10, 440).setRange(1, 30).setValue(1).setColorCaptionLabel(color(0));
  gui.getController("minBrightness").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  gui.addSlider("maxBrightness").setSize(130, 30).setCaptionLabel("White Point").setPosition(10, 500).setRange(1, 50).setValue(8).setColorCaptionLabel(color(0));
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
  println(p2.width);
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

void sldXSpacing(float value) {
  delta_dist = value;
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

void sldImgScale(int value) {
  imageScaleUp = value;
  needsReload = true;
  redrawImage();
}

void circleCountSet(int value) {
  cirlceCount = value;
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
  gui.getController("tglInvert").setValue(0);
  gui.getController("sldXSpacing").setValue(2.0);
  gui.getController("circleCountSet").setValue(50);
  gui.getController("sldImgScale").setValue(1);
  gui.getController("lineWidth").setValue(2);
  gui.getController("minBrightness").setValue(1);
  gui.getController("maxBrightness").setValue(8);
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
  float xOffset = 0;
  float x = start_x;
  float y = start_y;
  int b;

  if (!isRecording) {
    background(255);
    xOffset = 150;
  }

  float scaleFactor = 1.0/imageScaleUp;
  strokeWeight(strokeWidth * scaleFactor);

  float theta = 0;
  float r = 10;
  float r_step = (p2.height/2 - r/2)/(cirlceCount-1);
  if(p2.height > p2.width) {
    r_step = (p2.width/2 - r/2)/(cirlceCount-1);
    xOffset = 0;
  }
  float angle_step = asin(delta_dist/r)*2;
  int i = 0;
  while(i < cirlceCount) {
    x = r * cos(theta) + start_x;
    y = r * sin(theta) + start_y;
    b = (int)alpha(p2.get((int)x, (int)y));
    b=255-b;
    z = int(map(b, 0, 255, minB, maxB));      // Brightness trimmed to range.
    //curveVertex(x, y);
    float s_x = (r +(z/2)) * cos(theta) + start_x + xOffset;
    float s_y = (r +(z/2)) * sin(theta) + start_y;
    float f_x = (r -(z/2)) * cos(theta) + start_x + xOffset;
    float f_y = (r -(z/2)) * sin(theta) + start_y;
    line(s_x, s_y, f_x, f_y);
    theta+=angle_step;
    if(theta >= 6.28) {
      theta = 0;
      r+=r_step;
      i++;
      angle_step = asin(delta_dist/r)*2;
    } 
  }
  endShape();
}
