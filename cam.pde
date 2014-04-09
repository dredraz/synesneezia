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

zone.x+=3;
if (zone.x > width){
zone.x = -zone.width;
}
zone.show();  

}

class Zone {  
  int x, y,width,height; 
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
}
