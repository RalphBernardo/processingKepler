// Plot class makes a rectangular canvas

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
    // rectMode(CORNERS)
    // interprets the first two parameters of rect() as the location of one corner
    // and the third and fourth parameters as the location of the opposite corner
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
