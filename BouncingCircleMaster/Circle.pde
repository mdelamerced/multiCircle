class EllipseIcon {
  //ATTRIBUTES
 
  float xspeed = 1;
  float yspeed = 1;
  float b;
  float c;

  boolean stopped = false;

  //CONSTRUCTOR
  EllipseIcon() {
    xpos=random(201,599);
    ypos=random(201,599);
    b = random(255);
    c = random(100, 200);
  }

  //FUNCTIONS

  void drawEllipse() {
    fill(b, c, 255);
    ellipse(xpos, ypos, 399, 399);
  }

  void moveEllipse() {
    xpos = xpos +  xspeed ;  
    ypos = ypos +  yspeed ;
  }  

  void checkBounce() {
    if (xpos > 600 || xpos < 200) {
      xspeed *= -1;
    }
    if (ypos > 600 || ypos < 200) {
      yspeed *= -1;
    }
  }
}

