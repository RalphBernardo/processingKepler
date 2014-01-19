// Point2D class holds data in its own x and y 
// reflects the x- and y- coordinate of the point

class Point2D {
  float x, y;
  
  //class "constructor"
  // what happens when declare
  // an object of type Point2D, 
  // the initial x and y gets set

  Point2D(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  float x() {
    return x;
  }
  
  float y() {
    return y;
  }
}

