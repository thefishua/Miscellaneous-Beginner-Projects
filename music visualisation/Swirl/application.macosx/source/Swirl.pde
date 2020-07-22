// Music Visualisation Swirl using Mimic Library 

//VARIABLES
float n;
float n3;
float n5;
float speed2;
 
//MUSIC  
import ddf.minim.*;
import ddf.minim.signals.*;
Minim minim;
AudioPlayer mySound;
 
 
//MAIN SETUP
void setup () {
  fullScreen(P3D);
  noCursor();
  smooth();
  background (0);
 
  //MUSIC | Add mp3 to file and change name of "hey.mp3" to your song name
  minim = new Minim(this);
   mySound = minim.loadFile("song.mp3");    
  mySound.play();
}
 
 
void draw () {
 
  fill(0, 20);  
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);// centre
 
  for (int i = 0; i < mySound.bufferSize() -1; i++) {
 
    float angle = sin(i+(n-2))*40; // angle
    float x = sin(radians(i))*(n/angle); // new angle
 
    float leftLevel = mySound.left.level() * 50; // size
    ellipse(i, i, leftLevel, leftLevel);
    rotateZ(n*-PI/3*0.05); // Rotation delete multi for weid effect
 
    fill(random(255), random(255), random(255)); //colour change
 
  }
 
  n += 0.005 ;
  n3 += speed2;
  n5 += speed2;
 
}
