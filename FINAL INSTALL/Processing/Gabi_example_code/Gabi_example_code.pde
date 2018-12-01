/**
 * Loop.
 *
 * Shows how to load and play a QuickTime movie file.
 *
 */

import processing.video.*;
  import processing.serial.*;



Movie day;
Movie night;
Movie rain;
Movie grows;
Movie shrink;

boolean nightActive = false;
boolean cueNight = false;
boolean nightPossible = true;
boolean rainActive = false;
boolean cueRain = false;
boolean growsActive = false;
boolean shrinkActive = false;

boolean vidInProg = false;

int numPeop = 0;

void setup() {
  size(1920, 1080);
  //fullScreen(2);
  background(0);

  serialSetup();

  // Load and play the video in a loop
  day = new Movie(this, "day_1.mp4");
  day.loop();


  // Load and play the video in a loop
  night = new Movie(this, "night.mp4");
  //night.loop();

  // Load and play the video in a loop
  rain = new Movie(this, "rain.mp4");
  //rain.loop();


  // Load and play the video in a loop
  grows = new Movie(this, "grows.mp4");
  //grows.loop();


  // Load and play the video in a loop
  shrink = new Movie(this, "shrink.mp4");
  //shrink.loop();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  //if (movie.available() == true) {
  //  movie.read();
  //}


  if(nightActive){
    night.play();
    image(night, 0, 0, width, height);
    if(night.time() >= night.duration()-0.5){
      vidInProg = false;
      nightActive = false;
      night.stop();
     //println("shrink finished");
     //shrink.stop();
    }
  } else if (rainActive){
    rain.play();
    image(rain, 0, 0, width, height);
    if(rain.time() >= rain.duration()-0.5){
      vidInProg = false;
      rainActive = false;
      rain.stop();
    }
  } else if (growsActive){
    image(grows, 0, 0, width, height);
    if(grows.time() >= grows.duration()-1){
      vidInProg = false;
      grows.stop();
      growsActive = false;
      nightPossible = true;
     println("grows finished");
    }
  } else if (shrinkActive){
    image(shrink, 0, 0, width, height);
    //println(shrink.time(), shrink.duration());
    if(shrink.time() >= shrink.duration()-1){
      vidInProg = false;
     println("shrink finished");
    }
  } else {
      image(day, 0, 0, width, height);

  }

  // force update every 2 seconds
  if(frameCount % (int(frameRate))== 0 ){ update(); }

  if(millis()%1000 == 0){ update(); }
}



void update(){


  println(vidInProg);
  println(shrinkActive);
  println(growsActive);
  print("num of people: ");
  println(numPeop);

  if(numPeop > 2 && !shrinkActive && !vidInProg){
        shrink.play();

    shrinkActive = true;
    vidInProg = true;
    nightPossible = false;
  } else if(shrinkActive && numPeop <= 2 && !vidInProg){
        grows.play();

    println("growing");
    shrinkActive = false;
    growsActive = true;
    vidInProg = true;
        shrink.stop();

  }

  if(cueNight && !vidInProg && !growsActive && !nightActive){
    cueNight = false;
    nightActive = true;
    vidInProg = true;
  }

  if(cueRain && !vidInProg && !growsActive && !rainActive){
    cueRain = false;
    rainActive = true;
    vidInProg = true;}
  //if(

  //if(numPeop < 2){
  //  growsActive = true;
  //}
}


void keyPressed() {
  println( key );

    if(key == 'a'){
    numPeop++;
  }
  if(key == 's'){
    numPeop--;
    if(numPeop < 0){ numPeop = 0; }
  }

  if(key == 'z'){
    cueNight = true;
  }

    if(key == 'x'){
    rainActive = true;
  }

  update();
}



////connecting arduino code in processing
Serial myPort;                       // The serial port


void serialSetup() {
  // Print a list of the serial ports for debugging purposes
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my Mac is always my FTDI
  // adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}


void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  //println(inByte);

  if (inByte == 49) {
    numPeop++;
  }
  if (inByte == 50) {
    numPeop--;
    if (numPeop < 0) {
      numPeop = 0;
    }
  }

  if (inByte == 51) {
    cueNight = true;
  }

  if (inByte == 52) {
    cueRain = true;
  }

  if(inByte >= 49 && inByte <= 52){
    update();
  }
}
