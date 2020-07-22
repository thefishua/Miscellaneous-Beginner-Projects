float n = 0;
// Size of the Whole Radial 
float c = 50/2;

ArrayList<PVector> points = new ArrayList<PVector>();

float start = 0;

void setup() {
 fullScreen();
 // Colours of the Radial 
 colorMode(HSB, 360, 255, 255);
}

void draw() {
 background(0);
 translate(width/2, height/2);
 LSD();
 n += 10;
 start += 10;
}

// Function that creates the rotating radial 
void LSD() {
  rotate(n / 0.01);
 for (int i = 0; i < n; i++) {
  float a = i * radians(137.5);
  float r = c * sqrt(i);
  float x = r * cos(a);
  float y = r * sin(a);
  float hu = i + start;
  hu = i/3.0 % 360;
  fill(hu, 255, 255);
  noStroke();
  // size of dots
  ellipse(x, y, 20, 20);
 }
}
