
  // Graphing sketch

  // This program takes ASCII-encoded strings from the serial port at 9600 baud
  // and graphs them. It expects values in the range 0 to 1023, followed by a
  // newline, or newline and carriage return

  // created 20 Apr 2005
  // updated 24 Nov 2015
  // by Tom Igoe
  // This example code is in the public domain.
import processing.video.*;
  import processing.serial.*;
  
  Movie calm1;
  Movie calm2;
  Movie calm3;
  Movie anx1;
  Movie anx2;
  Movie anx3;
  Movie romance;

  Serial myPort;        // The serial port
  int xPos = 1;         // horizontal position of the graph
  float inByte = 0;
  int s1 = -999;
  int s2 = -999;
  int s3 = -999;
  

  void setup () {
    // set the window size:
    size(400, 300);

    // List all the available serial ports
    // if using Processing 2.1 or later, use Serial.printArray()
    println(Serial.list()[3]);

    // I know that the first port in the serial list on my Mac is always my
    // Arduino, so I open Serial.list()[0].
    // Open whatever port is the one you're using.
    myPort = new Serial(this, Serial.list()[0], 9600);

    // don't generate a serialEvent() unless you get a newline character:
    myPort.bufferUntil('\n');

    // set initial background:
    background(0);
  }

  void draw () {
    // draw the line:
 
  }

  void serialEvent (Serial myPort) {
    // get the ASCII string:
    String inString = myPort.readStringUntil('\n');

    if (inString != null) {
      // trim off any whitespace:
      inString = trim(inString);
      String[] sList = split(inString, ',');
      
      s1 = int(sList[0]);
      s2 = int(sList[1]);
      s3 = int(sList[4]);
      
      println(s1);
      println(s2);
      println(s3);
      
      //println(inString);
      // convert to an int and map to the screen height:
      //inByte = float(inString);
      //println(inByte);
      //inByte = map(inByte, 0, 1023, 0, height);
    }
  }
