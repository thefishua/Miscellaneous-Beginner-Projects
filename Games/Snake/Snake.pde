// Snake Game 
int w = 50;
int h = 50;

int snakeLength = 2;

int snakeHeadX;
int snakeHeadY;

char snakeDirection = 'R';

int maxSnakeLength = 500;

int[] x = new int[maxSnakeLength];
int[] y = new int[maxSnakeLength];

boolean foodKey = true;

int foodX;
int foodY;

int backgroundColor = 244;

int bestScore = snakeLength;

boolean gameOverKey = false;

void setup() {
  fullScreen();
  frameRate(10);
  noStroke();
}

void draw() {
  listenGameOver();
  if( isSnakeDie() ){
    return;
  }
  background(backgroundColor);
  if (keyPressed && key == CODED) {
    switch(keyCode){
      case LEFT:
        if(snakeDirection != 'R'){
          snakeDirection = 'L';
        }
        break;
      case RIGHT:
        if(snakeDirection != 'L'){
          snakeDirection = 'R';
        }
        break;
      case DOWN:
        if(snakeDirection != 'U'){
          snakeDirection = 'D';
        }
        break;
      case UP:
        if(snakeDirection != 'D'){
          snakeDirection = 'U';
        }
        break;
    }
  }
  switch(snakeDirection){
    case 'L':
      snakeHeadX -= w;
      break;
    case 'R':
      snakeHeadX += w;
      break;
    case 'D':
      snakeHeadY += w;
      break;
    case 'U':
      snakeHeadY -= w;
      break;
  }
  drawFood(width, height);
  drawSnake();
  if( snakeHeadX == foodX && snakeHeadY == foodY ){
    snakeLength++;
    foodKey = true;
  }
}
void snakeInit(){
  snakeLength = 2;
  gameOverKey = false;
  snakeHeadX = 0;
  snakeHeadY = 0;
  snakeDirection = 'R';
}

void drawSnake() {
  for (int i=snakeLength-1; i>0; i--) {
    x[i] = x[i-1];
    y[i] = y[i-1];
  }
  y[0] = snakeHeadY;
  x[0] = snakeHeadX;
  fill(#7B6DB7);
  for (int i=0; i<snakeLength; i++) {
    rect(x[i], y[i], w, h);
  }
}
void drawFood(int maxWidth, int maxHeight) {
  fill(#ED1818);
  if ( foodKey ) {
    foodX = int( random(0, maxWidth)/w  ) * w;
    foodY = int( random(0, maxHeight)/h ) * h;
  }
  
  rect(foodX, foodY, w, h);
  foodKey = false;
}

void listenGameOver(){
  if( gameOverKey && keyPressed && (key == 'r' || key == 'R') ){
    snakeInit();
  }
}

void showGameOver(){
  pushMatrix();
  gameOverKey = true;
  bestScore = bestScore > snakeLength ? bestScore : snakeLength;
  background(0);
  translate(width/2, height/2 - 50);
  fill(255);
  textAlign(CENTER);
  textSize(84);
  text("GAMEOVER", 0, 0);
  textSize(64);
  text("SCORE  "+ snakeLength + " / BEST  " + bestScore, 0, 150);
  fill(120);
  textSize(18);
  text("Game over, press 'R' to restart.", 0, 260);
  popMatrix();
}
boolean isSnakeDie(){
  if( snakeHeadX < 0 || snakeHeadX >= width || snakeHeadY < 0 || snakeHeadY >= height){
    showGameOver();
    return true;
  }
  if( snakeLength > 2 ){
    for( int i=1; i<snakeLength; i++ ){
      if( snakeHeadX == x[i] && snakeHeadY == y[i] ){
        showGameOver();
        return true;
      }
    }
  }
  
  return false;
}
