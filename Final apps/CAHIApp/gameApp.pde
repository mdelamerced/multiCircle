class GameApp {


  void gameStart() {
    background(255);
    video.read();
    fill(0);
    textFont(gFont, 36);
    text("OTHER PLAYERS", 715, 40); 
    text("click on the circle and follow it", 50, 700);
    text("around the screen. Don't let go!", 50, 750);
    image(video, 700, 50, 320, 240);
    image(video1,700, 290, 320, 240);
     image(video2,700, 530, 320, 240);
    Timer.drawTimer();
    
    if (Ellipse1.stopped == false) {
      Ellipse1.moveEllipse();
    }
    Ellipse1.checkBounce();
    Ellipse1.drawEllipse();
  }

}

