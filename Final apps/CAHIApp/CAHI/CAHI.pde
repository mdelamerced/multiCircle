//connect computers
import oscP5.*;
import netP5.*; 

//load images
PImage startImage;
PImage overImage;
PImage logoImage;

int phase = 1;
int sync = 1;

//Webcamera stream via UDP
import processing.video.*;
import javax.imageio.*;
import java.awt.image.*; 

// This is the port we are sending to
int clientPort = 9100; 
// This is our object that sends UDP out
DatagramSocket ds; 
// Capture object
Capture cam;

//Receiving video stream
PImage video1;
PImage video2;

ReceiverThread thread1;
ReceiverThread thread2;

/*
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
/* 
 //cameras
 CaptureAxisCamera video;
 CaptureAxisCamera1 video1;
 CaptureAxisCamera2 video2;
 */
EllipseIcon Ellipse1;
Start Start;
Wait Wait;
GameOver GameOver;
GameApp GameApp;
Timer Timer;
float xpos, ypos;
PFont gFont;

int timeout = 3; // to slow the mouse down a little
int value = 0; //check what this is

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {

  size(1024, 768);
  noStroke();

  /*  //video
   video = new CaptureAxisCamera(this, "128.122.151.28", 640, 480, false);
   video1 = new CaptureAxisCamera1(this, "128.122.151.237", 640, 480, false);
   video2 = new CaptureAxisCamera2(this, "128.122.151.82", 640, 480, false);*/

  //  video thread to receive
  video1 = createImage(320, 240, RGB);
  video2 = createImage(320, 240, RGB);
  thread1 = new ReceiverThread(video1.width, video1.height, 9100);
  thread1.start();

  thread2 = new ReceiverThread(video2.width, video2.height, 9101);
  thread2.start();

  //load images
  startImage = loadImage("startgame.png");
  overImage = loadImage("gameover.png");
  logoImage = loadImage("clickholdit.png");

  //gameplay
  Ellipse1 = new EllipseIcon();
  Start = new Start();
  Wait = new Wait();
  GameOver = new GameOver();
  GameApp = new GameApp();
  Timer = new Timer();

  //load font
  gFont = loadFont ("SynchroLET-48.vlw");

  //to sync computers
  oscP5 = new OscP5(this, 32000);
  myRemoteLocation = new NetAddress("198.1.100.1", 12000);
  // Setting up the DatagramSocket, requires try/catch
  try {
    ds = new DatagramSocket();
  } 
  catch (SocketException e) {
    e.printStackTrace();
  }
  // Initialize Camera
  cam = new Capture( this, 320, 240, 30);
  cam.start();
}

void draw() {


  switch (phase) {
  case 1:
    Start.drawStart();
    break;
  case 2:
    Wait.waitingToPlay();
    break;
  case 3:
    GameApp.gameStart();
    break;
  case 4:
    GameOver.drawOver();
    break;
  default:
    phase = 1;
  }
  if (thread1.available()) {
    video1 = thread1.getImage();
  }

  if (thread2.available()) {
    video2 = thread2.getImage();
  }
}

void captureEvent( Capture c ) {
  c.read();
  // Whenever we get a new image, send it!
  broadcast(c);
}

void broadcast(PImage img) {

  // We need a buffered image to do the JPG encoding
  BufferedImage bimg = new BufferedImage( img.width, img.height, BufferedImage.TYPE_INT_RGB );

  // Transfer pixels from localFrame to the BufferedImage
  img.loadPixels();
  bimg.setRGB( 0, 0, img.width, img.height, img.pixels, 0, img.width);

  // Need these output streams to get image as bytes for UDP communication
  ByteArrayOutputStream baStream  = new ByteArrayOutputStream();
  BufferedOutputStream bos    = new BufferedOutputStream(baStream);

  // Turn the BufferedImage into a JPG and put it in the BufferedOutputStream
  // Requires try/catch
  try {
    ImageIO.write(bimg, "jpg", bos);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  // Get the byte array, which we will send out via UDP!
  byte[] packet = baStream.toByteArray();

  // Send JPEG data as a datagram
  println("Sending datagram with " + packet.length + " bytes");
  try {
    ds.send(new DatagramPacket(packet, packet.length, InetAddress.getByName("198.1.100.4"), clientPort));
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}


void mouseDragged() {
  if ( mouseX < xpos+200 && mouseX > xpos-200 && mouseY > ypos-200 && mouseY < ypos+200) {
    println("mouse in the house");
  }
  else
    if ( mouseX > xpos+200 || mouseX < xpos-200 || mouseY < ypos-200 || mouseY > ypos+200) {
      phase = 4;
    }
}

void mouseReleased() {
  if (phase == 3 && mouseX < xpos+200 && mouseX > xpos-200 && mouseY > ypos-200 && mouseY < ypos+200) {
    phase++;
  }
}

void mousePressed() {
  if (phase == 4) {
    phase++;
  }
}

void keyPressed() {
  oscP5.send("/test", new Object[] {
    new Integer("1"), new Float(2.0), "test string."
  }
  , myRemoteLocation);
  if (phase==1) {
    phase++;
  }
}



/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  if (theOscMessage.checkAddrPattern("/test")==true) {
    /* check if the typetag is the right one. */
    //if(theOscMessage.checkTypetag("ifs")) {
    /* parse theOscMessage and extract the values from the osc message arguments. */
    /* int firstValue = theOscMessage.get(0).intValue();  // get the first osc argument
     float secondValue = theOscMessage.get(1).floatValue(); // get the second osc argument
     String thirdValue = theOscMessage.get(2).stringValue(); // get the third osc argument
     print("### received an osc message /test with typetag ifs.");
     println(" values: "+firstValue+", "+secondValue+", "+thirdValue);
     return;*/
    phase = 3;
    //}
  }
  println("### received an osc message. with address pattern "+
    theOscMessage.addrPattern()+" typetag "+ theOscMessage.typetag());
}

