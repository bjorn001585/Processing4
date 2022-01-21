import controlP5.*;

ControlP5 cp5;

PVector p, v, g, d, vent;
int r = 25;

void setup() {
  size(800, 500);
  frameRate(60);
  
  p = new PVector(width/2, height/2);
  g = new PVector(0, 0.5);
  d = new PVector(0, 0);
  vent = new PVector(0.5, 0);
  v = PVector.random2D();
  
  cp5 = new ControlP5(this);
  addSlider("speed", 10, 100, 10);
  addSlider("damp", 0, 1, 1);
  addSlider("drag", 0, 001, 0);
  addSlider("vent", 0, 1, 0);
  addSlider("water", 0, 1, 0);
  addSlider("radius", 5, 50, 5);

  cp5.addButton("reset")
    .setPosition(120, 10)
    .setSize(100, 20);
}

void reset() {
  v = PVector.random2D();
  p = new PVector(width/2, height/2);
  
  v.normalize();
  v.mult(cp5.get(Slider.class, "speed").getValue());
}

void draw() {
  background(#fafafa);
  
  float damp = getSliderValue("damp");
  float drag = getSliderValue("drag");
  float ventv = getSliderValue("vent");
  float water = getSliderValue("water");
  float r = getSliderValue("radius");
  
  v.add(g);
  p.add(v);
  
  d = v.copy();
  d.mult(v.mag() * drag * (r * r) * 0.001);
  v.sub(d);
  
  vent.set(-1, 0);
  vent.mult(ventv * (r * r) * 0.001);
  
  v.add(vent);
  
  if(p.y > height * 2 / 3) {
    v.mult(water);
  }
  
  if(p.x < r / 2) {
    v.x = -v.x;
    v.mult(damp);
    p.x = r / 2;
  }
  
  if(p.x > width - r / 2) {
    v.x = -v.x;
    v.mult(damp);
    p.x = width - r / 2;
  }
  
  if(p.y < r / 2) {
    v.y = -v.y;
    v.mult(damp);
    p.y = r / 2;
  }
  
  if(p.y > height - r / 2) {
    v.y = -v.y;
    v.mult(damp);
    p.y = height - r / 2;
  }
  
  fill(#15C2FF);
  noStroke();
  rect(0, height * 2 / 3, width, height / 2);
  fill(0);
  circle(p.x, p.y, r);
}

int offset = 10;
int gap = 5;

Slider addSlider(String name, int min, int max, int init) {
  int sx = 100, sy = 20;
  
  Slider slider = cp5.addSlider(name)
    .setPosition(10, offset)
    .setSize(sx, sy)
    .setRange(min, max)
    .setValue(init);

  cp5.get(Slider.class, name)
    .getCaptionLabel()
    .setPaddingX(-30);
    
  offset += sy + gap;
  return slider;
}

float getSliderValue(String name) {
  return cp5.get(Slider.class, name).getValue();
}
