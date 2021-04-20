


/**
 * Incorporates code from ASCII Video by Ben Fry and other Processing examples.
 * 
 * Text characters have been used to represent images since the earliest computers.
 * This sketch is a simple homage that re-interprets live video as ASCII text.
 * See the keyPressed function for more options, like changing the font size.
 */



import processing.svg.*;
import de.ixdhof.hershey.*;

import processing.pdf.*;


// All ASCII characters, sorted according to their visual density
String letterOrder =
  " .`-_':,;^=+/\"|)\\<>)iv%xclrs{*}I?!][1taeo7zjLu" +
  "nT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@KHDBWNMR0Q";
char[] letters;
HersheyFont hf;
float cellWidth = 14;
float cellHeight = 20;

int x = 30;

PFont font_MB48;
PFont font_MB24;
PImage img;
  
void setup() 
{ 

// PDF Export is in *inches*, at the size of 1"/72 pixels.
// 12*72 = 864, so use 864 pixels for 12x12 output, or 1080x1080 for 15x15" output
 
 img = loadImage("othercat-small.jpg"); // Load the original image
 
  size(img.width, img.height);
  
  hf = new HersheyFont(this, "futural.jhf");
  beginRecord(SVG, "filename.svg");
 int count = img.width * img.height;
 
 
 
  // for the 256 levels of brightness, distribute the letters across
  // the an array of 256 elements to use for the lookup
  letters = new char[256];
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, letterOrder.length()));
    letters[i] = letterOrder.charAt(index);
  } 
   


  

 
  
  // Load the font. Fonts must be placed within the data 
  // directory of your sketch. Use Tools > Create Font 
  // to create a distributable bitmap font. 
  // For vector fonts, use the createFont() function. 
  
   // Uncomment the following two lines to see the available fonts 
 // String[] fontList = PFont.list();
  //println(fontList);
  
  
   // MISO Typeface from http://omkrets.se/typografi/
//   font_MB48  = loadFont("Miso-Bold-48.vlw");
//   font_MB24  = loadFont("Miso-Bold-24.vlw");

  font_MB48  = createFont("Courier-Bold", 48);
   font_MB48  = createFont("Courier", 48);
  font_MB24  = createFont("Courier", 24);




  // Only draw once
  noLoop();
}

void draw() {
  
image(img, 0, 0); // Displays the image from point (0,0) 
img.loadPixels();

 background(255); 
 
PGraphics pdf = beginRecord(PDF, "output.pdf");

// set only the PDF renderer to use textMode(SHAPE)
pdf.textMode(SHAPE);
textFont( font_MB48, 24); 
 
   fill(0);
    
  // iterate over the image, pull out "pixels" and 
  // average the brightness in each region.
  for (int y =0; y < img.height; y += cellHeight)
  { 
    for (int x=0; x < img.width; x += cellWidth) 
    { 
      int pixelcount = 0;
      long brightcount = 0;
        for (int yc =0; yc < cellHeight; yc++)
  { 
    for (int xc=0; xc < cellWidth; xc++) 
    { 
      pixelcount++;
      color colrtmp = img.get(x + xc,y+yc);
      brightcount += ((int)brightness(colrtmp)); 
    }
}
        
     float brtemp =    ( brightcount /  pixelcount); // Average brightness of region
 //   fill(br);
  
  int br = (int) (brtemp * brtemp / 256);
 // int br = (int) ( brtemp);
  
 if (br > 255)
 br = 255;
 
 br = 255 - br; // invert brightness map
// fill(br);

       text(letters[br], x, y); 
    }
  }
  
    
 
  endRecord();
   
}
