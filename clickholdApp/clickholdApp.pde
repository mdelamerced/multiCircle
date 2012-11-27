import oscP5.*;
import netP5.*;

EllipseIcon Ellipse1;
Start Start;
GameOver GameOver;
Button Button;
float xpos, ypos;

PFont gFont;

int page = 1;

int timeout = 3; // to slow the mouse down a little
int value = 0;

OscP5 oscP5;
OscMessage m;
NetAddressList myNetAddressList = new NetAddressList();
/* listeningPort is the port the server is listening for incoming messages */
int myListeningPort = 32000;
/* the broadcast port is the port the clients should listen for incoming messages from the server*/
int myBroadcastPort = 12000;

String myConnectPattern = "/server/connect";
String myDisconnectPattern = "/server/disconnect";


void setup() {
  size(800, 600);
  noStroke();
  Ellipse1 = new EllipseIcon();
  Start = new Start();
  GameOver = new GameOver();
  //  Button = new Button();
  oscP5 = new OscP5(this, myListeningPort);
  frameRate(25);
  gFont = loadFont ("SynchroLET-48.vlw");
}

void draw() {
  startPage();
}

void startPage() {
  Start.drawStart();

  if (myNetAddressList.list().size() == 1 ) {
    gameApp();
  }
}

void gameApp() {
  background(255);

  if (Ellipse1.stopped == false) {
    Ellipse1.moveEllipse();
  }
  Ellipse1.checkBounce();
  Ellipse1.drawEllipse();
}


void mouseDragged() {
  if ( mouseX < xpos+200 && mouseX > xpos-200 && mouseY > ypos-200 && mouseY < ypos+200) {
    println("yei");
  }
  else
    if ( mouseX > xpos+200 || mouseX < xpos-200 || mouseY < ypos-200 || mouseY > ypos+200) {
      //println ("nay");
      GameOver.drawOver();
      //  window.location = "http://google.com";
    }
}


void mouseReleased() {

  GameOver.drawOver();
  // println("nope");
}


//OSC Messages Events

void oscEvent(OscMessage theOscMessage) {
  /* check if the address pattern fits any of our patterns */
  if (theOscMessage.addrPattern().equals(myConnectPattern)) {
    connect(theOscMessage.netAddress().address());
  }
  else if (theOscMessage.addrPattern().equals(myDisconnectPattern)) {
    disconnect(theOscMessage.netAddress().address());
  }
  /**
   * if pattern matching was not successful, then broadcast the incoming
   * message to all addresses in the netAddresList. 
   */
  else {
    oscP5.send(theOscMessage, myNetAddressList);
  }
}


private void connect(String theIPaddress) {
  if (!myNetAddressList.contains(theIPaddress, myBroadcastPort)) {
    myNetAddressList.add(new NetAddress(theIPaddress, myBroadcastPort));
    println("### adding "+theIPaddress+" to the list.");
  } 
  else {
    println("### "+theIPaddress+" is already connected.");
  }
  println("### currently there are "+myNetAddressList.list().size()+" remote locations connected.");
}



private void disconnect(String theIPaddress) {
  if (myNetAddressList.contains(theIPaddress, myBroadcastPort)) {
    myNetAddressList.remove(theIPaddress, myBroadcastPort);
    println("### removing "+theIPaddress+" from the list.");
  } 
  else {
    println("### "+theIPaddress+" is not connected.");
  }
  println("### currently there are "+myNetAddressList.list().size());
} 

