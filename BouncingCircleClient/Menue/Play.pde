
// the actual game play; your game logic would be here 

void MainProgram() {
  // depending on game chosen 
  switch (currentGame) {
  case chooseGame1:
    handleGame1();
    break;
  case chooseGame2:
    handleGame2();
    break;
  case chooseGame3:
    handleGame3();
    break;
  default:
    // error 
    println ("Error 17 in tab Play (unknown currentGame) with "
      + currentGame 
      + ".");
    exit();
    break;
  } // switch
} // func 

// ------------------------------------------------------

void handleGame1() {
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
  text ("You play '" + 
    chooseGameName[currentGame] + 
    "' here. ", textXPos, 280);  
  textSize(19);
  text("", 
  textXPos, 230);
  text("Press mouse button.", 500, height-30);
  //
}

void handleGame2() {
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
  text ("You play '" + 
    chooseGameName[currentGame] + 
    "' here. ", textXPos, 280);  
  textSize(19);
  text("", 
  textXPos, 230);
  text("Press mouse button.", 500, height-30);
  //
}

void handleGame3() {
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
  text ("You play '" + 
    chooseGameName[currentGame] + 
    "' here. ", textXPos, 280);  
  textSize(19);
  text("", 
  textXPos, 230);
  text("Press mouse button.", 500, height-30);
  //
}
// 

