class GameApp {


  void gameStart() {
    background(255);
    video.read();
    fill(0);
    textFont(gFont, 36);
    text("PLAYER 1", 715, 40); 
    image(video, 700, 50, 320, 240);
    
    if (Ellipse1.stopped == false) {
      Ellipse1.moveEllipse();
    }
    Ellipse1.checkBounce();
    Ellipse1.drawEllipse();
  }

}

