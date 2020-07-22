class Clyde {
 PVector pos = new PVector(1 * 16 + 8, 29 * 16 + 8);
 PVector vel = new PVector(1, 0);
 Path bestPath;
 ArrayList<Node> ghostNodes = new ArrayList<Node>();
 Node start;
 Node end;
 color colour = color (255,100,0);
 
 boolean chase = true;
 boolean frightened = false;
 int flashCount = 0;
 int chaseCount = 0;
 boolean returnHome = false;
 boolean deadForABit = false;
 int deadCount = 0;
 
 Clyde() {
  setPath(); 
 }
 
 void show() {
  chaseCount++;
  if (chase) {
    if (chaseCount > 2000) {
      chase = false;
      chaseCount = 0;
    }
  } else {
   if (chaseCount > 700) {
    chase = true;
    chaseCount = 0;
   }
  }
  
  if (deadForABit) {
    deadCount++;
    if (deadCount > 300) {
     deadForABit = false; 
    }
  } else {
    if (!frightened) {
     if (returnHome) {
      stroke(colour, 100);
      fill(colour, 100);
     } else {
      stroke(colour);
      fill(colour);
     }
     bestPath.show();
    } else {
      flashCount++;
      if (flashCount > 800) {
       frightened = false;
       flashCount = 0;
      }
      
      if (floor(flashCount / 30) % 2 == 0) {
       stroke(255);
       fill(255);
      } else {
       stroke(0,0,200);
       fill(0,0,200);
      }
    }
    ellipse(pos.x, pos.y, 20, 20);
  }
 }
 
 void move() {
  if (!deadForABit) {
   pos.add(vel);
   checkDirection();
  }
 }
 
 void setPath() {
  ghostNodes.clear();
  setNodes();
  start = ghostNodes.get(0);
  end = ghostNodes.get(ghostNodes.size() -1);
  Path temp = AStar(start,end,vel);
  if (temp != null) {
    bestPath = temp.clone();
  }
 }
 
 void setNodes() {
  ghostNodes.add(new Node((pos.x-8)/16, (pos.y-8)/16));
  for(int i = 1; i < 27; i++) {
   for(int j = 1; j < 30; j++) {
    // if there is a space above or below and a space left or right then this space is a node
    if (!tiles[j][i].wall) {
     if (!tiles[j-1][i].wall || !tiles[j+1][i].wall) { //check up for space
        if (!tiles[j][i-1].wall || !tiles[j][i+1].wall) {//check left and right for space
  
          ghostNodes.add(new Node(i, j));//add the nodes
        }
      }
    }
   }
  }
  if (returnHome) {
    ghostNodes.add(new Node(13,11));
  } else {
    if (chase) {
      if (dist((pos.x-8)/16, (pos.y-8)/16, (pacman.pos.x-8) / 16, (pacman.pos.y-8)/16) > 8) {

        ghostNodes.add(new Node((pacman.pos.x-8) / 16, (pacman.pos.y-8)/16));
      } else {

        ghostNodes.add(new Node(1, 29));
      }
    } else {//scatter
      ghostNodes.add(new Node(1, 29));
    }
  }
  
  for (int i = 0; i < ghostNodes.size(); i++) {
   ghostNodes.get(i).addEdges(ghostNodes); 
  }
 }
 
 void checkDirection() {
  if (pacman.hitPacman(pos)) {
   if (frightened) {
    returnHome = true;
    frightened = false;
   } else if (!returnHome) {
    pacman.kill(); 
   }
  }
  
  if (returnHome) {
   if (dist((pos.x-8)/16, (pos.y - 8)/16, 13, 11) < 1) {
    returnHome = false; 
    deadForABit = true;
    deadCount = 0;
   }
  }
  
  if ((pos.x-8)%16 == 0 && (pos.y - 8)% 16 == 0) { // critical position
    PVector matrixPosition = new PVector((pos.x-8)/16, (pos.y - 8)/16);
    
    if (frightened) {
     boolean isNode = false;
     for (int j = 0; j < ghostNodes.size(); j++) {
      if (matrixPosition.x ==  ghostNodes.get(j).x && matrixPosition.y == ghostNodes.get(j).y) {
        isNode = true;
      }
     }
     if (!isNode) {//if not on a node then no need to do anything
          return;
      } else {//if on a node
        //set a random direction
        PVector newVel = new PVector();
        int rand = floor(random(4));
        switch(rand) {
        case 0:
          newVel = new PVector(1, 0);
          break;
        case 1:
          newVel = new PVector(0, 1);
          break;
        case 2:
          newVel = new PVector(-1, 0);
          break;
        case 3:
          newVel = new PVector(0, -1);
          break;
        }
        
        //if the random velocity is into a wall or in the opposite direction then choose another one
          while (tiles[floor(matrixPosition.y + newVel.y)][floor(matrixPosition.x + newVel.x)].wall || (newVel.x +2*vel.x ==0 && newVel.y + 2*vel.y ==0)) {
            rand = floor(random(4));
            switch(rand) {
            case 0:
              newVel = new PVector(1, 0);
              break;
            case 1:
              newVel = new PVector(0, 1);
              break;
            case 2:
              newVel = new PVector(-1, 0);
              break;
            case 3:
              newVel = new PVector(0, -1);
              break;
            }
          }
          vel = new PVector(newVel.x/2, newVel.y/2);//halve the speed
        }
     } else {
      setPath();
      
      for (int i = 0; i < bestPath.path.size(); i++) {
       if (matrixPosition.x == bestPath.path.get(i).x && matrixPosition.y == bestPath.path.get(i).y) {
        vel = new PVector(bestPath.path.get(i+1).x - matrixPosition.x, bestPath.path.get(i+1).y - matrixPosition.y); 
        vel.limit(1);
        return;
       }
      }
     }
    }
  }
 }
