import processing.video.*;

Capture video;

PImage prevFrame;

Zone zone;


void setup(){
  size(640,480);
  zone = new Zone(100,100,440,280);
  video = new Capture(this,width,height,30);
  prevFrame = createImage(video.width, video.height,RGB);
  stroke(0,0,255);
}

void draw(){
  if(video.available()){
    prevFrame.copy(video, 0, 0, video.width, video.height,0,0,video.width, video.height);
    prevFrame.updatePixels();
    video.read();  
  }
  
  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();
  int w = video.width;
  int h = video.height;
  for(int x = 0; x < video.width; x++){
    for(int y = 0; y < video.height; y++){
      int loc = y+x*video.height;
      pixels[loc] = video.pixels[loc];
      //pixels[w*h-loc-1] = video.pixels[loc];
      //pixels[abs(int(random(1,w))*int(random(1,h))-loc-1)] = video.pixels[loc];
    }
  }
  updatePixels();
 
 
  // verticle lines 
 /* for(int x = 64; x < width; x += 64){
  
   line(x,0,x,video.height);
  }  
  
  for(int y = 0; y < height; y += 48){
     // line();
    }
  */


  //Zone draws  

  /*zone.x+=3;
  if (zone.x > width){
    zone.x = -zone.width;
  }
  zone.show();*/  
  zone.check();
}

class Zone {  
  
  
  int x, y,width,height; 
  
  float threshold = 12;
  
  
  Zone (int x, int y, int w, int h) {  
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
  } 
  void show(){
    noFill();
    rect(x,y,width,height);
  }
  
  // look at change of pixel data in the zone
  void check(){
    float total = 0; 
    float average = 0;
    // Begin loop to walk through every pixel
    for (int x = this.x; x < this.width; x ++ ) {
      for (int y = this.y; y < this.height; y ++ ) {
       
        int loc = x + y*video.width;            // Step 1, what is the 1D pixel location
        color current = video.pixels[loc];      // Step 2, what is the current color
        color previous = prevFrame.pixels[loc]; // Step 3, what is the previous color
       
        // Step 4, compare colors (previous vs. current)
        float r1 = red(current); float g1 = green(current); float b1 = blue(current);
        float r2 = red(previous); float g2 = green(previous); float b2 = blue(previous);
        float diff = dist(r1,g1,b1,r2,g2,b2);
        
        total = total + diff;
        
     
        }
    }
   
    average = total / (this.width * this.height);
   
   
    
    
    if (average > this.threshold) {
        // If motion, display show block 
        this.show();
    }
  } // end check()
} // end Zone
