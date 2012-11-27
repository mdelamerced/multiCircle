import oscP5.*;
import netP5.*;

EllipseIcon Ellipse1;
Start Start;
GameOver GameOver;
Button button;
GameApp GameApp;
float xpos, ypos;

PFont gFont;

int timeout = 3; // to slow the mouse down a little
int value =0;
int phase = 1;

OscP5 oscP5;
OscMessage m;

/* a NetAddress contains the ip address and port number of a remote location in the network. */
NetAddress myBroadcastLocation; 
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
  GameApp = new GameApp();
  button = new Button(250, 337, 10, color(204), color(255), color(0));
  gFont = loadFont ("SynchroLET-48.vlw");
  /* create a new instance of oscP5. 
   * 12000 is the port number you are listening for incoming osc messages.
   */
  oscP5 = new OscP5(this, 12000);

  /* create a new NetAddress. a NetAddress is used when sending osc messages
   * with the oscP5.send method.
   */

  /* the address of the osc broadcast server */
  myBroadcastLocation = new NetAddress("127.0.0.1", 32000); //local instance, use real IP address for other computers
}

void draw() {
  // startPage();
  GameApp.gameStart();
  if (phase > 1){
    GameOver.drawOver(); 
  }
  
  
}

void startPage() {
  Start.drawStart();

  if (myNetAddressList.list().size() == 1 && button.press()) {
    GameApp.gameStart();
  }
}


void mousePressed() {
  println("nope");
 // phase++;

  /* create a new OscMessage with an address pattern, in this case /test. */
  OscMessage myOscMessage = new OscMessage("/test");
  /* add a value (an integer) to the OscMessage */
  myOscMessage.add(100);
  /* send the OscMessage to a remote location specified in myNetAddress */
  oscP5.send(myOscMessage, myBroadcastLocation);
}


void mouseDragged() {
  if ( mouseX < xpos+200 && mouseX > xpos-200 && mouseY > ypos-200 && mouseY < ypos+200) {
    println("yei");
  }
  else
    if ( mouseX > xpos+200 || mouseX < xpos-200 || mouseY < ypos-200 || mouseY > ypos+200) {
      println ("nay");
      phase++;
      m = new OscMessage("/server/disconnect", new Object[0]);
      oscP5.flush(m, myBroadcastLocation);  
     
      //   break;
      //  window.location = "http://google.com";
    }
}


void mouseReleased() {
  println("nope");
  m = new OscMessage("/server/disconnect", new Object[0]);
  oscP5.flush(m, myBroadcastLocation); 
  GameOver.drawOver(); 
  //break;
}







void keyPressed() {
  OscMessage m;
  switch(key) {
    case('c'):
    /* connect to the broadcaster */
    m = new OscMessage("/server/connect", new Object[0]);
    oscP5.flush(m, myBroadcastLocation);  
    break;
    case('d'):
    /* disconnect from the broadcaster */
    m = new OscMessage("/server/disconnect", new Object[0]);
    oscP5.flush(m, myBroadcastLocation);  
    break;
  }
}

void oscEvent(OscMessage theOscMessage) {
  /* get and print the address pattern and the typetag of the received OscMessage */
  println("### received an osc message with addrpattern "+theOscMessage.addrPattern()+" and typetag "+theOscMessage.typetag());
  theOscMessage.print();
}

