// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Box2D particle system example
import java.util.*;
import processing.opengl.*; // opengl
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import blobDetection.*; // blobs
import toxi.geom.*; // toxiclibs shapes and vectors
import toxi.processing.*; // toxiclibs display


// A reference to our box2d world
Box2DProcessing box2d;
VideoSource source;

PolygonBlob poly; 
BlobDetection theBlobDetection;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;

// A list for all particle systems
ArrayList<ParticleSystem> systems;

void setup() {
  size(400,300, P3D);
  smooth();
  // Init boundaries
  source = new VideoSource(this);
  source.setup();
  theBlobDetection = source.theBlobDetection;
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
 
  // We are setting a custom gravity
  box2d.setGravity(0, -20);

  // Create ArrayLists	
  systems = new ArrayList<ParticleSystem>();
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(50,100,300,5,-0.3));

}

void draw() {
  background(255);
  
  // We must always step through time!
  box2d.step();
  source.getNewShapes();

  // Run all the particle systems
  for (ParticleSystem system: systems) {
    system.run();

    int n = (int) random(0,2);
    system.addParticles(n);
  }

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }
  
  image(source.canvas,0,0, width, height);
}


void mousePressed() {
  // Add a new Particle System whenever the mouse is clicked
  systems.add(new ParticleSystem(0, new PVector(mouseX,mouseY)));
}





