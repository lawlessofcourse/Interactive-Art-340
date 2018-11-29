//IMPORT OSCP5 FOR SUPERCOLLIDER ANALYSIS
import netP5.*;
import oscP5.*;

//DRAW VARIABLES
static final int NUM_LINES = 50;
static final int NUM_DOTS = 500;
float t;
float col = 0;

//OSC VARIABLES
float ampSlow;
float ampFast;
float note;
float ampSlow2;
float ampFast2;
float note2;
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup(){
  background(20);
  size(500, 500);
  //set osc ip and port
  oscP5 = new OscP5(this,7000);
}

void draw(){
  background(20);
  if(col>255){
    col =0;
}
col += 0.5;
float col1 = col;
float col2 = col + 55;
float col3 = col + 155;
   
    println(ampFast*2000);
  strokeWeight(5);
  translate(width/2, height/2);
  
  for(int i = 0; i < NUM_DOTS; i++){
    stroke(col1, ampFast*2500, col3 );
    point(x1(t + i), y1(t + i));
  }for(int i = 0; i < NUM_DOTS; i++){
    stroke(col1, col3, ampFast*2000 );
    point(x2(t + i), y2(t + i));
  } 
  for(int i = 0; i < NUM_LINES; i++){
    stroke(col3, col3, ampFast*2000 );
    line(x1(t + i), y1(t + i), x2(t + i), y2(t + i) );
  }
  t+= 0.5;
}

float x1(float t){
  //println(floor(note/2));
  return sin(sin(sin(t / 25)) * (note/15)) * sin(t/10)*250 ;
   //return sin(sin(sin(t / 25)) * (note/3)) * sin(t/10)*200 ;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}

float y1(float t){
  return cos(t / (note/2)) * 200; //(2*(ampSlow*1000)) ;
 //THIS ONE IS DANK return cos(t / 5) * 100; //(2*(ampSlow*1000)) ;
}
float x2(float t){
  return sin(t / 5) * (ampSlow*1000) + sin(t) * 2;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}
float y2(float t){
  return cos(t / 20) * 200 + cos(t/12)*20;
}


void oscEvent(OscMessage theOscMessage) {
  // MIC 1 ANALYSIS //
  if(theOscMessage.addrPattern().equals("1: ampSlow") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    ampSlow = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: ampFast") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    ampFast = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("1: note") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    note = (theOscMessage.get(0).floatValue());
  }  
  //Mic 2 analysis
  if(theOscMessage.addrPattern().equals("2: ampSlow") == true){
    //println(theOscMessage.get(0).floatValue());
   // println(theOscMessage.addrPattern());
    ampSlow2 = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("2: ampFast") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    ampFast2 = (theOscMessage.get(0).floatValue()); 
  }if(theOscMessage.addrPattern().equals("2: note") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    note2 = (theOscMessage.get(0).floatValue());
  }
}
