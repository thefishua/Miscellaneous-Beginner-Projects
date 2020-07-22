class Path {
 LinkedList<Node> path = new LinkedList<Node>();
 float distance = 0;
 float distToFinish = 0;
 PVector velAtLast;
 
 Path() {
 }
 
 void addToTail(Node n, Node endNode) {
   if (!path.isEmpty()) {
    distance += dist(path.getLast().x, path.getLast().y, n.x, n.y); 
   }
   path.add(n);
   distToFinish = dist(path.getLast().x, path.getLast().y, endNode.x, endNode.y);
 }
 Path clone() {
  Path temp = new Path();
  temp.path = (LinkedList)path.clone();
  temp.distance = distance;
  temp.distToFinish = distToFinish;
  temp.velAtLast = new PVector(velAtLast.x, velAtLast.y);
  return temp;
 }
 
 void clear() {
  distance = 0;
  distToFinish = 0;
  path.clear();
 }
 
 void show() {
  strokeWeight(2);
    for (int i = 0; i< path.size()-1; i++) {
      line(path.get(i).x*16 +8, path.get(i).y*16 +8, path.get(i+1).x*16 +8, path.get(i+1).y*16 +8);//
    }
    ellipse((path.get(path.size() -1).x*16)+8, (path.get(path.size() -1).y*16)+8, 5, 5); 
 }
}
