class Circle {
  float x, y, r, a;
  color c;
  String n;
  int t;
 
  Circle(float x, float y, float r, color c, String n, int t, float a) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.c = c;
    this.n = n;
    this.t = t;
    this.a = a;
  }
  
  void display() {
    
    // check if mouseover
    if (dist(mouseX, mouseY, x, y) <= r) {
      fill(0);
    } else {
      fill(c);
    }
    
    noStroke();
    ellipse(x, y, r*2, r*2);
  }
  
  void displayLabel() {
    if (dist(mouseX, mouseY, x, y) <= r) {
      //String info = ", x: " + int(x) + ", y: " + int(y);
      String info = "KOI Name: " + n + "\nRadius: " + int(r) + " Earth radius" + "\nTemperature: " + t + " K" + "\nSemi-Major Axis: " + a + " AU";
      Label label = new Label(info, mouseX, mouseY);
    }
  }
}
