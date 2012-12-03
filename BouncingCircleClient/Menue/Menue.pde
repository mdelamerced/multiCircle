/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/77308*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
//
// Main 
//
// Titel
final String strConstTitel = "Menue Test ";
//
// states for the program (see tab States)
final int stateWelcomeScreen  = 0; // Menue at the beginning 
final int statePlay           = 1; // playing the game that has beeen chosen
final int stateLearnMore      = 2; // show help / learn more
final int stateAfterAGame     = 3; // after game, before returning to Welcome Screen
// current state 
int state = stateWelcomeScreen;
//
// Games: 
final int chooseGame1 = 0;
final int chooseGame2 = 1;
final int chooseGame3 = 2;
// their names 
final String [] chooseGameName = 
{ 
  "Tic-tac-toe", 
  "Peg Solitaire", 
  "Chess", 
  "Learn more"
};
final String [] statusText = 
{
  "Game I description ", 
  "Game II description ", 
  "Game III description ", 
  "Learn more about the games."
};
//
// current game
int currentGame = chooseGame1;
//
// the initial Main Menu
int textXPos;
int learnPos; 
int[] textYPos = { 
  230, 
  390, 
  550, 
  700
};
//
// rectangles as buttons for main menu 
Rectangle rectButtonBoard1; 
Rectangle rectButtonBoard2; 
Rectangle rectButtonBoard3;
Rectangle rectLearnmore; 
//
// ========================================================================================================

void setup () {
  size (900, 800 );
  // define values for class Rectangle
  textXPos = width/2-300;
  learnPos = textXPos+400;
  // define objects of class Rectangle
  rectButtonBoard1 = new Rectangle(textXPos, textYPos[0], 500, 145, chooseGameName[0], statusText[0], 0);
  rectButtonBoard2 = new Rectangle(textXPos, textYPos[1], 500, 145, chooseGameName[1], statusText[1], 1);
  rectButtonBoard3 = new Rectangle(textXPos, textYPos[2], 500, 145, chooseGameName[2], statusText[2], 2);  
  rectLearnmore    = new Rectangle(learnPos, textYPos[3], 100, 25, chooseGameName[3], statusText[3], -1);
}

void draw () {
  background(0);
  // see tab States for handling the states 
  switch (state) {
  case stateWelcomeScreen:
    handleStateShowWelcomeScreen();
    break;
  case statePlay:
    handleStatePlay();
    break;
  case stateLearnMore:
    handleStateLearnMore();
    break;
  case stateAfterAGame:
    handleStateAfterAGame();
    break;
  default:
    // error 
    println("Unknown State (Error 33 in main tab): " 
      + state
      + ".");
    exit();
    break;
  } // switch
} // func 
//

