import oscP5.*;
import netP5.*;

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
/*CaptureAxisCamera2 video2;
 CaptureAxisCamera3 video3;
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


void setup() {
  background(0);
  size(1024, 768);
  noStroke();
  video = new CaptureAxisCamera(this, "128.122.151.28", 640, 480, false);
  /*video2 = new CaptureAxisCamera2(this, "128.122.151.28", 640, 480, false);
   video3 = new CaptureAxisCamera3(this, "128.122.151.28", 640, 480, false);
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
  } 

  textFont(appFont, 48);
  text("LIVE GAME", 400, 700);
  text("There are  "+myNetAddressList.list().size()+"  players ready.", 200, 750);
}

void beginGame() {
  if (myNetAddressList.list().size() == 1) {
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


/*
---------Axis Camera Code  DO NOT MODIFY BELOW THIS LINE----------------
 */

public class CaptureAxisCamera extends PImage implements Runnable {
  public boolean useMJPGStream = false;

  public String ip = "";
  public String jpgURL = "http://128.122.151.200axis-cgi/jpg/image.cgi?resolution=352x240";

  public String mjpgURL  = "http://128.122.151.189/axis-cgi/mjpg/video.cgi?resolution=352x240";

  DataInputStream dis;

  Image image;

  BufferedImage bimage;

  public Dimension imageSize = null;

  public boolean connected = false;

  private boolean initCompleted = false;

  HttpURLConnection huc = null;

  PApplet parent;

  boolean crop;

  boolean available;

  Method captureEventMethod;

  /** Creates a new instance of AxisCamera */
  public CaptureAxisCamera(PApplet _parent, String _ip, int _w, int _h, boolean _useMJPGStream) {
    ip = _ip;
    parent = _parent;
    useMJPGStream = _useMJPGStream;
    jpgURL = "http://"+ ip + "/axis-cgi/jpg/image.cgi?resolution="+ String.valueOf(_w)+ "x" +String.valueOf(_h);

    //jpgURL = "";
    mjpgURL  = "http://"+ ip +"/axis-cgi/mjpg/video.cgi?resolution"+ String.valueOf(_w)+ "x" +String.valueOf(_h);

    // initialize my PImage self
    super.init(_w, _h, RGB);




    try {
      captureEventMethod = parent.getClass().getMethod("captureEvent", new Class[] { 
        CaptureAxisCamera.class
      }
      );
    } 
    catch (Exception e) {
      // no such method, or an error.. which is fine, just ignore
    }



    Thread myThread = new Thread(this);
    myThread.start();

    parent.registerDispose(this);
  }

  /**
   * True if a frame is ready to be read.
   * 
   * <PRE> // put this somewhere inside draw if (capture.available()) capture.read();
   * 
   * </PRE>
   * 
   * Alternatively, you can use captureEvent(Capture c) to notify you whenever available() is set to true. In which case, things might look like this:
   * 
   * <PRE>
   * 
   * public void captureEvent(Capture c) { c.read(); // do something exciting now that c has been updated }
   * 
   * </PRE>
   */
  public boolean available() {
    return available;
  }

  public void read() {
    // try {
    // synchronized (capture) {
    if (image != null) {
      loadPixels();
      synchronized (pixels) {
        // System.out.println("read1");
        if (crop) {
          // System.out.println("read2a");
          // f#$)(#$ing quicktime / jni is so g-d slow, calling copyToArray
          // for the invidual rows is literally 100x slower. instead, first
          // copy the entire buffer to a separate array (i didn't need that
          // memory anyway), and do an arraycopy for each row.
          /*
         * if (data == null) { data = new int[dataWidth * dataHeight]; } raw.copyToArray(0, data, 0, dataWidth * dataHeight); int sourceOffset = cropX + cropY * dataWidth; int destOffset = 0; for (int y = 0; y < cropH; y++) { System.arraycopy(data, sourceOffset, pixels, destOffset, cropW); sourceOffset += dataWidth; destOffset += width; }
           */
        } 
        else { // no crop, just copy directly
          // System.out.println("read2b");
          // theData = (byte[]) imageBuffer.getData();

          PixelGrabber pg = new PixelGrabber(image, 0, 0, width, height, pixels, 0, width);

          try {
            pg.grabPixels();
          } 
          catch (InterruptedException e) {
          }
          // raw.copyToArray(0, pixels, 0, width * height);
          // }
          // System.out.println("read3");
        }
        available = false;
        // mark this image as modified so that PGraphicsJava2D and
        // PGraphicsOpenGL will properly re-blit and draw this guy
        updatePixels();
        // System.out.println("read4");
      }
    }
  }
  public void connect() {
    try {
      URL u = new URL(useMJPGStream ? mjpgURL : jpgURL);
      huc = (HttpURLConnection) u.openConnection();
      // System.out.println(huc.getContentType());
      InputStream is = huc.getInputStream();
      connected = true;
      BufferedInputStream bis = new BufferedInputStream(is);
      dis = new DataInputStream(bis);
      if (!initCompleted) initDisplay();
    } 
    catch (IOException e) { // incase no connection exists wait and try again, instead of printing the error
      try {
        huc.disconnect();
        Thread.sleep(60);
      } 
      catch (InterruptedException ie) {
        huc.disconnect();
        connect();
      }
      connect();
    } 
    catch (Exception e) {
      ;
    }
  }

  public void initDisplay() { // setup the display
    if (useMJPGStream)
      readMJPGStream();
    else {
      readJPG();
      disconnect();
    }
    initCompleted = true;
  }

  public void disconnect() {
    try {
      if (connected) {
        dis.close();
        connected = false;
      }
    } 
    catch (Exception e) {
      ;
    }
  }


  public void readStream() { // the basic method to continuously read the stream
    try {
      if (useMJPGStream) {
        while (true) {
          readMJPGStream();
        }
      } 
      else {
        while (true) {
          connect();
          readJPG();

          disconnect();
        }
      }
    } 
    catch (Exception e) {
      ;
    }
  }

  public void readMJPGStream() { // preprocess the mjpg stream to remove the mjpg encapsulation
    readLine(3, dis); // discard the first 3 lines
    readJPG();
    readLine(2, dis); // discard the last two lines
  }
  public BufferedImage getImage() {
    available = false;
    return bimage;
  }
  public void readJPG() { // read the embedded jpeg image
    try {
      JPEGImageDecoder decoder = JPEGCodec.createJPEGDecoder(dis);
      bimage = decoder.decodeAsBufferedImage();
      image = bimage;
      available = true;
      if (captureEventMethod != null) {
        try {
          captureEventMethod.invoke(parent, new Object[] { 
            this
          }
          );
        } 
        catch (Exception e) {
          System.err.println("Disabling captureEvent()  because of an error.");
          e.printStackTrace();
          captureEventMethod = null;
        }
      }
    } 
    catch (Exception e) {
      e.printStackTrace();
      disconnect();
    }
  }
  /**
   * Called by PApplet to shut down video so that QuickTime can be used later by another applet.
   */
  public void dispose() {
    disconnect();
  }
  public void readLine(int n, DataInputStream dis) { // used to strip out the header lines
    for (int i = 0; i < n; i++) {
      readLine(dis);
    }
  }

  public void readLine(DataInputStream dis) {
    try {
      boolean end = false;
      String lineEnd = "\n"; // assumes that the end of the line is marked with this
      byte[] lineEndBytes = lineEnd.getBytes();
      byte[] byteBuf = new byte[lineEndBytes.length];

      while (!end) {
        dis.read(byteBuf, 0, lineEndBytes.length);
        String t = new String(byteBuf);
        // System.out.print(t); //uncomment if you want to see what the lines actually look like
        if (t.equals(lineEnd)) end = true;
      }
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
  } 

  public void run() {
    connect();
    readStream();
  }
}

