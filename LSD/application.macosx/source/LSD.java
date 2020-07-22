import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class LSD extends PApplet {

float n = 0;
// Size of the Whole Radial 
float c = 50/2;

ArrayList<PVector> points = new ArrayList<PVector>();

float start = 0;

public void setup() {
 
 // Colours of the Radial 
 colorMode(HSB, 360, 255, 255);
}

public void draw() {
 background(0);
 translate(width/2, height/2);
 LSD();
 n += 10;
 start += 10;
}

// Function that creates the rotating radial 
public void LSD() {
  rotate(n / 0.01f);
 for (int i = 0; i < n; i++) {
  float a = i * radians(137.5f);
  float r = c * sqrt(i);
  float x = r * cos(a);
  float y = r * sin(a);
  float hu = i + start;
  hu = i/3.0f % 360;
  fill(hu, 255, 255);
  noStroke();
  // size of dots
  ellipse(x, y, 20, 20);
 }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "LSD" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
