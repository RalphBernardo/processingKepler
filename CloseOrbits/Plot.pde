class Plot {
  Point2D topLeft, bottomRight;
  color c;
 
  Plot(int x1, int y1, int x2, int y2, color c) {
    topLeft = new Point2D(x1, y1);
    bottomRight = new Point2D(x2, y2);
    this.c = c;
  }
  
  void display() {
    fill(c);
    noStroke();
    rectMode(CORNERS);
    rect(topLeft.x, topLeft.y, bottomRight.x, bottomRight.y);
  }
  
  Point2D topLeft() {
    return topLeft;
  }
  
  Point2D bottomRight() {
    return bottomRight;
  }
  
  float w() {
    return bottomRight.x - topLeft.x;
  }
  
  float h() {
    return bottomRight.y - topLeft.y;
  }
}
