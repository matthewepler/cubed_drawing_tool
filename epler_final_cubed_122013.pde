import peasy.*;
PeasyCam cam;

import controlP5.*;
ControlP5 controlP5;
import java.awt.Frame;
import java.awt.BorderLayout;
ControlFrame cf;

import processing.pdf.*;


ArrayList<Cube> cubes = new ArrayList();
float boxSize, halfBox, barWidth;
int tDimension, spacer, sides;
boolean record = false;

void setup()
{
  size( 800, 800, OPENGL );

  cam = new PeasyCam(this, 100, 1, -1, 1);
  ortho(); // scroll out to see all shapes

  initControls();

  boxSize = width / 40;
  halfBox = boxSize / 2;
  barWidth = 0.5;
  tDimension = 5;
  spacer = 6;
  sides = 3;

  fill( 15 );
  noStroke();
  smooth();

  generateCubes();
  int half = (int) cubes.size()/2;
  Cube center = cubes.get( half );

  cam.lookAt( center.posX, center.posY, center.posZ );
}


void draw()
{  
  background( 0 );
  stroke(255);
  fill(255);

  if ( record ) 
  {
    beginRaw(PDF, "raw.pdf");
  }
  pushMatrix();
  for ( int i = 0; i < cubes.size(); i++ )
  {
    Cube thisCube = cubes.get( i );
    thisCube.render();
  }
  popMatrix();

  if ( record )
  {
    endRaw();
    println( "PDF saved" );
    exit();
  }

  //  float[] camPos = cam.getPosition();
  //  float[] camRot = cam.getRotations();
  //  float[] camCenter = cam.getLookAt();
  //  println( "Position: " + camPos[0] + ", " + camPos[1] + ", " + camPos[2] );
  //  println( "Rotation: " + camRot[0] + ", " + camRot[1] + ", " + camRot[2] );
  //  println( "LookAt: " + camCenter[0] + ", " + camCenter[1] + ", " + camCenter[2] );
}


void generateCubes() {
  for ( int y = 0; y < tDimension; y++ ) 		 // generate cubes one vertical level at a time
  {
    for ( int x = 0; x < tDimension; x++ )
    {
      for ( int z = 0; z < tDimension; z++ )
      {
        Cube newCube = new Cube( sides, x * boxSize * spacer, 
        y * boxSize * spacer * -1, 
        z * boxSize * spacer );
        cubes.add( newCube );
      }
    }
  }
}


void initControls()
{
  controlP5 = new ControlP5(this);
  cf = addControlFrame("controls", 200,200);
}

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation( 0, 0);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

