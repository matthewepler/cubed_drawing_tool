public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;

  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    cp5.addSlider("boxSize").plugTo(parent,"boxSize").setRange(5, 80).setValue(width/40);
    cp5.addSlider("barWidth").plugTo(parent,"barWidth").setRange(0,6).setValue(1).linebreak();
    cp5.addToggle("record").plugTo(parent,"record").setPosition(10, 100);
  }

  public void draw() {
    background(abc);
  }

  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }


  ControlP5 cp5;

  Object parent;
}

