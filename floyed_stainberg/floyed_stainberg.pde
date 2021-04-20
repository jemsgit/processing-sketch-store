PImage img;

void setup(){
  size(1000, 1000);
  background(255);
  noLoop();
}

void draw() {
  img = loadImage("cat2.png");
  img.filter(GRAY);
  img.loadPixels();
  
  for(int y = 0; y < img.height-1; y++) {
    for(int x= 1; x < img.width-1; x++) {
      int ind = index(x, y);
      color pixel = img.pixels[ind];
      float oldR = red(pixel);
      float oldG = green(pixel);
      float oldB = blue(pixel);

      int factor = 1;
      int newR = round(factor * oldR/255) * (255/factor);
      int newG = round(factor * oldG/255) * (255/factor);
      int newB = round(factor * oldB/255) * (255/factor);
      
      img.pixels[ind] = color(newR, newG, newB);

      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;
      
      ind = index(x+1, y);
      img.pixels[ind] = getNewColor(img.pixels[ind], errR, errG, errB, 7/16.0);
      ind = index(x-1, y+1);
      img.pixels[ind] = getNewColor(img.pixels[ind], errR, errG, errB, 3/16.0);
      ind = index(x, y+1);
      img.pixels[ind] = getNewColor(img.pixels[ind], errR, errG, errB, 5/16.0);
      ind = index(x+1, y+1);
      img.pixels[ind] = getNewColor(img.pixels[ind], errR, errG, errB, 1/16.0);
    }
  }
  img.updatePixels();
  image(img, 0, 0);
}

int index(int x, int y) {
  return x + y*img.width;
}

color getNewColor(color c, float errR, float errG, float errB, float k) {
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    
    r = r + errR * k;
    g = g + errG * k;
    b = b + errB * k;
    
    return color(r, g, b);
}
