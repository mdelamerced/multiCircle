class Timer {

  int timerStart = 0;
  int offset;

  int mill;
  int minutes;
  int seconds;
  int hundredths;

  boolean stopped = false;
  boolean continued = false;


  void drawTimer() {
  
    if (!stopped) {
      mill=(millis()-timerStart);
      if (continued) mill += offset;

      seconds = mill / 1000;
      minutes = seconds / 60;
      seconds = seconds % 60;
      hundredths = mill / 10 % 100;
    }

    fill(0, 0, 0);
    text(nf(minutes, 2, 0)+":"+nf(seconds, 2, 0)+":"+nf(hundredths, 2, 0), 50, 100);
   // text("key b for begin, s for stop, c for continue", 50, 140);
  }

  void keyPressed() { // pause
   /* if (key=='s') {
      stopped = true;
    }
    if (key=='b') { // reset
      stopped = false;
      continued = false;
      timerStart = millis();
    }
    if (key=='c') { // continue
      stopped = false;
      continued = true;
      timerStart = millis();

      offset = mill;
    }
  } */
}
}
