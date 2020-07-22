import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.signals.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Swirl extends PApplet {

// Music Visualisation Swirl using Mimic Library 

//VARIABLES
float n;
float n3;
float n5;
float speed2;
 
//MUSIC  


Minim minim;
AudioPlayer mySound;
 
 
//MAIN SETUP
public void setup () {
  
  noCursor();
  
  background (0);
 
  //MUSIC | Add mp3 to file and change name of "hey.mp3" to your song name
  minim = new Minim(this);
   mySound = minim.loadFile("song.mp3");    
  mySound.play();
}
 
 
public void draw () {
 
  fill(0, 20);  
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);// centre
 
  for (int i = 0; i < mySound.bufferSize() -1; i++) {
 
    float angle = sin(i+(n-2))*40; // angle
    float x = sin(radians(i))*(n/angle); // new angle
 
    float leftLevel = mySound.left.level() * 50; // size
    ellipse(i, i, leftLevel, leftLevel);
    rotateZ(n*-PI/3*0.05f); // Rotation delete multi for weid effect
 
    fill(random(255), random(255), random(255)); //colour change
 
  }
 
  n += 0.005f ;
  n3 += speed2;
  n5 += speed2;
 
}
  public void settings() {  fullScreen(P3D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Swirl" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
