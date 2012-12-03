

// states for the program 

void handleStateShowWelcomeScreen() {
  // 
  // shows the main menu with the main game buttons 
  // 
  // headline 
  fill(255);  
  textSize(32);
  textAlign(CENTER);
  text (strConstTitel, width/2, 40);
  //
  // intro text below headline 
  textSize(19);
  textAlign(LEFT);
  text ("Write some general information ", textXPos, 80);
  text ("here. ", textXPos, 80+30);    
  text ("You can find these lines in tab  ", textXPos, 80+30+30);    
  text ("states. ", textXPos, 80+30+30+30);    
  //
  // 1st game option
  rectButtonBoard1.outputRect(); 
  // 2nd game option 
  rectButtonBoard2.outputRect(); 
  // 3rd game option 
  rectButtonBoard3.outputRect(); 
  // learn more box
  rectLearnmore.outputRect();
  //
}
//
void handleStatePlay() {
  //
  MainProgram();
}
//
void handleStateLearnMore() {
  //
  textLearnMoreOnScreen();
}
//
void handleStateAfterAGame() {
  // After a game:
  // Wait for mousePressed 
  // to go to the Welcome Screen again. 
  background(0);
  // headline 
  fill(255);  
  textSize(32);
  textAlign(CENTER);
  text (strConstTitel, width/2, 40);
  //
  // intro text 
  textSize(19);
  textAlign(LEFT);
  text ("Game '" + 
    chooseGameName[currentGame] + 
    "' is finished. ", textXPos, 80);  
  textSize(19);
  text("Thank you for playing!", 
  textXPos, 230);
  text("Press mouse button.", 500, height-30);
  //
} // func 
// 

