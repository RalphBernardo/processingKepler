class Marker {
  
  Marker(String info, float x, float y) {
        
    // get text width
    float labelWidth = textWidth(info);
    
    // check if label would go beyond sketch dimensions
    if (x + labelWidth + 20 > width) {
      x -= labelWidth + 20;
    }
    
    // draw background
    fill(0);
    noStroke();
    rectMode(CORNER);
    rect(x, y, 1, -height/6);
    rect(x, y, 1, height/4);
    
    // draw info
    fill(0);
    //textSize(12);
    text(info, x + 10, y - height/8);
  }
}
