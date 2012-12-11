import oscP5.*;
import netP5.*;
PImage logo;

int players = 0;

PFont appFont;

//Axis Camera Code 
import java.awt.Dimension; 
import java.awt.Image; 
import java.awt.image.BufferedImage; 
import java.awt.image.PixelGrabber; 
import java.io.BufferedInputStream; 
import java.io.DataInputStream; 
import java.io.IOException; 
import java.io.InputStream; 
import java.lang.reflect.Method; 
import java.net.HttpURLConnection; 
import java.net.URL;
import processing.core.PApplet; 
import processing.core.PImage;
import com.sun.image.codec.jpeg.JPEGCodec; 
import com.sun.image.codec.jpeg.JPEGImageDecoder;

CaptureAxisCamera video;
CaptureAxisCamera2 video2;
 /*CaptureAxisCamera3 video3;
 CaptureAxisCamera4 video4;*/

boolean newFrame=false;

OscP5 oscP5;

NetAddressList myNetAddressList = new NetAddressList();
/* listeningPort is the port the server is listening for incoming messages */
int myListeningPort = 32000;
/* the broadcast port is the port the clients should listen for incoming messages from the server*/
int myBroadcastPort = 12000;

String myConnectPattern = "/server/connect";
String myDisconnectPattern = "/server/disconnect";
String readyMessage = "/client/ready";
String startMessage = "/client/start";


void setup() {
  background(0);
  size(1024, 768);
  noStroke();
  logo = loadImage("clickholdit.png");
  video = new CaptureAxisCamera(this, "128.122.151.28", 640, 480, false);
  video2 = new CaptureAxisCamera2(this, "http://172.26.15.124:8080/1/stream.html", 640, 480, false);
 /*  video3 = new CaptureAxisCamera3(this, "128.122.151.28", 640, 480, false);
   video4 = new CaptureAxisCamera4(this, "128.122.151.28", 640, 480, false);*/
  appFont = loadFont ("SynchroLET-48.vlw");
  oscP5 = new OscP5(this, myListeningPort);
  oscP5.plug(this, "test", "server");
  // frameRate(25);
}

void draw() {
  if (video.available()) {
    video.read();

    image(video, 0, 0, 512, 384);
    image(video2, 512,0,512,384);
  } 
  fill(0);
  rect (0, 380, 1024, 768);
  fill(255);
  textFont(appFont, 48);
  text("LIVE GAME", 400, 700);
  text("There are  "+myNetAddressList.list().size()+"  players ready.", 200, 750);
  image(logo,width/3, 200);
  
}

void beginGame() {
  if (myNetAddressList.list().size() == 4) {
    OscMessage myMessage = new OscMessage("server");
    myMessage.add(1);
    oscP5.send(myMessage);
  }
}

void captureEvent(CaptureAxisCamera video) {
  video.read();
}
/*
void captureEvent(CaptureAxisCamera2 video2) {
 video.read();
 }
 void captureEvent(CaptureAxisCamera3 video3) {
 video.read();
 }
 void captureEvent(CaptureAxisCamera4 video4) {
 video.read();
 }
 
 */

// =================  OSC Events  ===================
void oscEvent(OscMessage theOscMessage) {
  println("ALERT! Message recieved"+ theOscMessage.addrPattern());
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



