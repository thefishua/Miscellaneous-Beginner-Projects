ArrayList<Firework> fireworks;

PVector gravity = new PVector(0, 0.2);
void setup() {
  fullScreen(P3D);

  fireworks = new ArrayList<Firework>();
  colorMode(HSB);
  background(0);
}

void draw() {


  if (random(1) < 0.2) {
    fireworks.add(new Firework());
  }

  background(0);
  translate(width/2, height, -1000);


  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }
}
