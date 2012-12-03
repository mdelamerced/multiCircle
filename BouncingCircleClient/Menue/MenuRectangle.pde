
// for the Menu: class for the Rectangles (buttons)

class Rectangle {

  int x, y, w, h;   // Pos & Size  
  String textRect="";  // shown in the button (if in use)
  String textStatusBar=""; // shown in the status bar (if mouse over)
  int associatedGameIcon = -1; // which icon / graphical symbol to show 

  // constructor
  Rectangle( int _x, int _y, 
  int _w, int _h, 
  String _text, 
  String _textStatusBar, 
  int _associatedGameIcon ) {
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    textRect=_text;
    textStatusBar=_textStatusBar;
    associatedGameIcon = _associatedGameIcon;
  } // constructor
  //
  public void outputRect() {
    drawRectText(); 
    drawRect();
    showIconForGame();
  } // method 

  void showIconForGame() {
    switch (associatedGameIcon) {
    case -1:
      // none: do nothing 
      break;
    case 0: 
      tictactoeBoard(x+30, y+34);
      break;
    case 1: 
      solitaireBoard(x+40, y+40);
      break; 
    case 2: 
      chessBoard(x+40, y+40);
      break;
    default:
      // error
      println ("Error 23 with Solitaire: "
        + "Wrong number of associatedGameIcon. Tab MenuRectangle, associatedGameIcon: " 
        + associatedGameIcon 
        + " (counting from zero)." );  
      exit();
      break;
    } // switch
  } // func 

  void drawRect() {
    noFillOrLightColorDependingOnMouseOver();
    stroke(255);
    rect(x, y, w, h);
    // status bar 
    if (overRect()) {
      fill(255);
      textSize(17);      
      textAlign(LEFT);      
      text(textStatusBar, 15, height-15);
    }
  } // method 

  void drawRectText() {
    if (!textRect.equals("")) {
      fill(255);
      textSize(17);      
      textAlign(CENTER);  
      text(textRect, x, y+(h/2)-9, w, h);
    }
  } // method  

  boolean overRect() {
    if (mouseX>x && mouseX<x+w && 
      mouseY>y && mouseY<y+h) 
    {
      return true;
    } 
    else 
    {
      return false;
    } // if else
  } // method  
  //
  void noFillOrLightColorDependingOnMouseOver() {
    // this method sets a light background color for 
    // the button when mouse is over it
    if (overRect()) 
      fill(2, 255, 2, 42);
    else   
      noFill();
  } // method
  //
} // class
//

