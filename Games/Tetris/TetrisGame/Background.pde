public class Background{
  int[][][] colours;
  int r,g,b;
  int w, x, y;
  int score = 0;
  boolean playing = true;
  
  public  Background() {
    colours = new int[12][24][3];
    w = width/24;
  }
  
  public void display() {
    for(int i = 0; i < 12; i++) {
     for(int j = 0; j < 24; j++) {
      r = colours[i][j][0];
      g = colours[i][j][1];
      b = colours[i][j][2];
      fill(r,g,b);
      rect(i * w, j * w, w, w);
     }
    }
    for(int i = 0; i < 24; i++) {
     if (checkLine(i)) {
       removeLine(i);
     } 
    } 
    if (endGame()) {
     println("PLAYING = END");
     playing = false; 
    }
  }
  
  public void writeShape(Shape s) {
    // x and y coordinates of each block
    for (int i = 0; i < 4; i++){
      x = s.theShape[i][0];
      y = s.theShape[i][1];
      // Write the colours of the shape into the x and y values
      colours[x][y][0] = s.r;
      colours[x][y][1] = s.g;
      colours[x][y][2] = s.b;
   }
  }
  
  // Check for a complete line
  public boolean checkLine(int row) {
   for (int i = 0; i < 12; i++) {
     if (colours[i][row][0] == 0 && colours[i][row][1] == 0 && colours[i][row][2] == 0) {
       return false;
     }
   }
   return true;
  }
  // Remove Lines
  public void removeLine(int row) {
    score++;
    int[][][] newBackground = new int[12][24][3];
    for (int i = 0; i < 12; i++) {
      for(int j = 23; j > row; j--) {
       for (int a = 0; a < 3; a++) {
         newBackground[i][j][a] = colours[i][j][a];
       }
      }
      for(int r = row; r >= 1; r--) {
       for (int j = 0; j < 12; j++) {
         newBackground[j][r][0] = colours[j][r-1][0];
         newBackground[j][r][1] = colours[j][r-1][1];
         newBackground[j][r][2] = colours[j][r-1][2];
       }
      }
    }
    colours = newBackground; 
  }
  public boolean endGame() {
   if (colours[0][0][0] != 0) {
     return true;
   }
   return false;
  }
}
