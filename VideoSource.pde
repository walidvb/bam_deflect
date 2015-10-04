import codeanticode.syphon.*;

class VideoSource{
  PGraphics canvas;
  SyphonClient client;
  PApplet applet;
  VideoSource(PApplet applet){
     this.applet = applet;
  }
  void setup(){
    println("Available Syphon servers:");
    println(SyphonClient.listServers());
    // Create syhpon client to receive frames 
    
    // from the first available running server: 
    this.client = new SyphonClient(this.applet);
  
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
  
  PGraphics getImage(){
    if (this.client.available()) {
      this.canvas = this.client.getGraphics(canvas);
      return this.canvas;
    }
    else{
      return new PGraphics();
    }
  }
}
