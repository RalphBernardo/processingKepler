class Label {
  
  Label(String info, float x, float y) {
    
    // get text width
    float labelWidth = textWidth(info);
    
    // check if label would go beyond sketch dimensions
    if (x + labelWidth + 20 > width) {
      x -= labelWidth + 20;
    }
    
    // draw background
    fill(255);
    noStroke();
    rectMode(CORNER);
    rect(x + 10, y - 30, labelWidth + 10, 50); 
    
    // draw info
    fill(0);
    text(info, x + 15, y - 15);
  }
}
