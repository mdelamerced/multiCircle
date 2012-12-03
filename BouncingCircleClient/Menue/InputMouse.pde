
// Inputs Mouse

// each state has an own mousePressed routine 

void mousePressed() {
  // depending on the state choose mousePressed routine
  switch (state) {
  case stateWelcomeScreen:
    mousePressedStateWelcomeScreen();
    break;
  case statePlay:
    mousePressedStatePlay();
    break;
  case stateLearnMore:
    state = stateWelcomeScreen;
    break;
  case stateAfterAGame:
    state = stateWelcomeScreen;
    break;  
  default:
    println("Unknown State (Error 18 in tab InputMouse): " 
      + state+ ".");
    exit();
    break;
  } // switch
} // func 

// ----------------------------------------------------------------------------

void mousePressedStateWelcomeScreen() {
  // Mouse pressed in state Welcome Screen / Main Screen.
  // Evaluate three main buttons. 
  if (rectButtonBoard1.overRect()) {
    currentGame = chooseGame1;    
    state = statePlay;
  }
  else if (rectButtonBoard2.overRect()) {
    currentGame = chooseGame2;    
    state = statePlay;
  }
  else if (rectButtonBoard3.overRect()) {
    currentGame = chooseGame3;    
    state = statePlay;
  }  
  else if (rectLearnmore.overRect()) {
    printLearnMore();
    state = stateLearnMore;
  }
  else {
    // do nothing
  }
}
//
void mousePressedStatePlay() {
  // here would come your games logic. 
  // When game over, state = stateAfterAGame;
  // would apply.  
  switch (currentGame) {
  case chooseGame1:
    state = stateAfterAGame;
    break;
  case chooseGame2:
    state = stateAfterAGame;
    break;
  case chooseGame3:
    state = stateAfterAGame;
    break;
  default:
    println ("Error 66 in tab InputMouse for currentGame with "
      + currentGame);
    exit();
    break;
  } // switch
}
//

