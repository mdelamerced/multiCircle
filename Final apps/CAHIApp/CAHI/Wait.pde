class Wait {
  void waitingToPlay() {
    background(255);
    textFont(gFont, 48);
    fill(0);
    text("waiting for other players", 100, 50);
    cam.read();
    image(cam, 50, 150, 320, 240);
  /*  image(video1, 500, 150, 320, 240);
    image(video2, 250, 500, 320, 240);*/
  }
}

