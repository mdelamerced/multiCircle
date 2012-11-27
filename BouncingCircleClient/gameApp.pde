class GameApp {


  void gameStart() {
    background(255);
    if (Ellipse1.stopped == false) {
      Ellipse1.moveEllipse();
    }
    Ellipse1.checkBounce();
    Ellipse1.drawEllipse();
  }

}

