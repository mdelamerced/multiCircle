
// Menu: Show Games: Provides icon graphics for all 3 games   

final color colDark  = color ( 203, 117, 2 ); 
final color colLight = color ( 250, 177, 81 );

// -----------------------------------------------------

void tictactoeBoard ( int offsetX, int offsetY ) {
  // show tic-tac-toe board
  final int factor=16;
  stroke(colLight); 
  for (int i=0; i<2; i++) {
    // vertical  || 
    line ( offsetX+2*factor+i*factor, offsetY+factor, offsetX+2*factor+i*factor, offsetY+4*factor);
    // horizontal  = 
    line ( offsetX+factor, offsetY+2*factor+i*factor, offsetX+3*factor+factor, offsetY+2*factor+i*factor);
  } // for
} // func  

void solitaireBoard ( int offsetX, int offsetY ) {
  // show solitaire board
  //
  // define board (English Board) as String[]  
  String[] board = new String [7];
  board[0] = "  OOO  "; // O means peg
  board[1] = "  OOO  "; // space sign means non existing      
  board[2] = "OOOOOOO";
  board[3] = "OOOXOOO"; // X means empty hole
  board[4] = "OOOOOOO";            
  board[5] = "  OOO  ";
  board[6] = "  OOO  ";
  // 
  final int cols = 7;
  final int rows = 7;
  final int sizeCircle = 7;
  final int scaling = 10;
  //
  boolean ErrorOccured = false; 
  //
  // Begin loop 
  for (int i = 0; i < cols; i++) {  
    // check length of this String
    if (board[i].length() != cols) {
      // error
      println ("Error 56 with Solitaire: "
        + "Wrong number of signs in a line. Tab MenuIcons, line in board: " 
        + i 
        + " (counting from zero)." );  
      ErrorOccured = true; 
      exit();
    }
    if (!ErrorOccured) {
      // Begin loop
      for (int j = 0; j < rows; j++) { 
        // Scaling up to get a position at (x,y)
        int x = i*scaling; 
        int y = j*scaling; 
        // depending on board data
        switch ( board[i].charAt(j) ) {
        case 'O':
          // O means peg 
          fill(colLight);
          noStroke();
          ellipse(x+offsetX, y+offsetY, sizeCircle, sizeCircle);
          break;
        case 'X':
          // X means empty hole
          noFill();
          stroke(colDark);
          ellipse(x+offsetX, y+offsetY, sizeCircle, sizeCircle);
          break;
        case ' ':
          // space sign means non existing 
          // do nothing 
          break;
        default:
          // error
          println ("Error 70 Solitaire, line 70, " 
            + "tab MenuIcons, forbidden sign '" 
            + board[i].charAt(j) + "' at line " 
            + i 
            + ", sign number " 
            + j 
            + "." );  
          exit();
          break;
        } // switch
      } // for
    } // if
  } // for
} // func 

void chessBoard(int offsetX, int offsetY) {
  // show chess
  final int cols = 8;
  final int rows = 8;
  //
  final int sizeRect = 7;
  // Begin loop 
  for (int i = 0; i < cols; i++) { 
    // Begin loop
    for (int j = 0; j < rows; j++) { 

      // Scaling up to draw a rectangle at (x,y)
      int x = i*sizeRect; 
      int y = j*sizeRect; 

      noStroke(); // stroke(0);
      fill(colLight); // light
      if (x % 2 == 0) {
        if ( y % 2 == 0 ) {
          // do nothing / keep light
        } 
        else {
          fill(colDark);
        }
      }
      else {
        if ( y % 2 == 0 ) {
          fill(colDark);
        }
      }
      // For every column and row, a rectangle is drawn at an (x,y) location
      rect(x+offsetX, y+offsetY, sizeRect, sizeRect);
    } // for
  } // for
} // func 
// 

