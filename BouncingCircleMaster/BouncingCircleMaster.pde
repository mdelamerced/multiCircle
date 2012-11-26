EllipseIcon Ellipse1;
float xpos, ypos;

int timeout = 3; // to slow the mouse down a little
int value =0;


void setup() {
  size(800, 800);
  noStroke();
  Ellipse1 = new EllipseIcon();
}

void draw() {
  background(255);

  if (Ellipse1.stopped == false) {
    Ellipse1.moveEllipse();
  }
  Ellipse1.checkBounce();
  Ellipse1.drawEllipse();

  timeout--;
}

void mouseDragged() {
  if ( mouseX < xpos+200 && mouseX > xpos-200 && mouseY > ypos-200 && mouseY < ypos+200) {
    println("yei");
  }
  else
    if ( mouseX > xpos+200 || mouseX < xpos-200 || mouseY < ypos-200 || mouseY > ypos+200) {
      println ("nay");
    //  window.location = "http://google.com";
    }
}


void mouseReleased() {
  println("nope");
//window.location = "http://google.com";
  /* if ( mouseX > xpos+200 || mouseX < xpos-200 || mouseY < ypos-200 || mouseY > ypos+200) {
   println("nope");
   }
   fill(value);
   if (value == 0) {
   value = 255;
   } 
   else {
   value = 0;
   }
   */
}

