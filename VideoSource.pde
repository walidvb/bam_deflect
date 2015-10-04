import codeanticode.syphon.*;

class VideoSource{
  PGraphics canvas;
  SyphonClient client;
  BlobDetection theBlobDetection;

  int width, height;
  boolean available;
  PApplet applet;
  VideoSource(PApplet applet){
     this.applet = applet;
     this.width = applet.width;
     this.height = applet.height;
     this.available = false;
  }
  void setup(){
    println("Available Syphon servers:");
    println(SyphonClient.listServers());
    // Create syhpon client to receive frames 
    // from the first available running server: 
    this.client = new SyphonClient(this.applet);
    this.canvas = new PGraphics();
    
    theBlobDetection = new BlobDetection(640, 480);
    theBlobDetection.setThreshold(0.2);
    // A Syphon server can be specified by the name of the application that it contains it,
    // its name, or both:
    
    // Only application name.
    //client = new SyphonClient(this, "SendFrames");
      
    // Both application and server names
    //client = new SyphonClient(this, "SendFrames", "Processing Syphon");
    
    // Only server name
    //client = new SyphonClient(this, "", "Processing Syphon");
      
    // An application can have several servers:
    //client = new SyphonClient(this, "Quartz Composer", "Raw Image");
    //client = new SyphonClient(this, "Quartz Composer", "Scene");
  }
  
  boolean isReady(){
      return this.available;
  }
  int count = 0;
  void getNewShapes(){
    if(this.client.available()){
      this.canvas = this.client.getGraphics(canvas);
      this.canvas.loadPixels();
      theBlobDetection.computeBlobs(this.canvas.pixels);
    }
  }
  PGraphics getImage(){
    if (this.client.available()) {
      this.available = true;
      //this.canvas = this.client.getGraphics(canvas);
    }
    return this.canvas;
  }
}
