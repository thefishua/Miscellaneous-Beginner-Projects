PImage gameover;
PImage box;

Shape shape, onDeck;
Grid grid;
Background bg;

void setup() {
 size(720,720);
 grid = new Grid();
 shape = new Shape();
 shape.isActive = true;
 onDeck = new Shape(); 
 bg = new Background();
 gameover = loadImage("gameover.jpg");
 box = loadImage("box.jpg");
}

void draw() {
 background(51);
 if (bg.playing == true) {
   bg.display();
   grid.display();
   drawShape();
   fill(255);
   textSize(30);
   text("Score: " + bg.score, width/2 + 100, height - 100);
 } else if (key == 'r') {
   bg = new Background();
   grid = new Grid();
 } else { 
   background(0);
   fill(255);
   textSize(30);
   text("Final Score: " + bg.score, width/2 + 50, height - 400);
   bg.display();
   image(gameover, 80, 260);
 }
}

void drawShape() {
 shape.display();
 onDeck.showOnDeck();
 if (shape.checkBack(bg)) {
  shape.moveDown(); 
 } else {
  shape.isActive = false;  
 }
 shape.moveDown();
 if (!shape.isActive) {
    bg.writeShape(shape);
    shape = onDeck; 
    shape.isActive = true;
    onDeck = new Shape(); 
 }
}

void keyPressed() {
 if (keyCode == RIGHT) {
   shape.moveShape("RIGHT");
 } else if (keyCode == LEFT) {
   shape.moveShape("LEFT");
 } else if (keyCode == DOWN) {
   shape.moveShape("DOWN");
 } 
 
 if (keyCode == UP) {
  shape.rotate();
  shape.rotate();
 }
 shape.rotCount++;
}
