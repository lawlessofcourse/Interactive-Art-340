//IMPORT OSCP5 FOR SUPERCOLLIDER ANALYSIS
import netP5.*;
import oscP5.*;

//DRAW VARIABLES
static final int NUM_LINES = 50;
static final int NUM_DOTS = 1000;
float t;
float col = 0;

//OSC VARIABLES
float ampSlow;
float ampFast;
float note;
float ampSlow2;
float ampFast2;
float note2;
int onset;
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup(){
  background(20);
  //size(500, 500);
  //change size to screen size when presenting
  fullScreen();
  
  //set osc ip and port
  oscP5 = new OscP5(this,7000);
}

void draw(){
  background(20);
  //if col value goes above 255 reset to 0
  if(col>255){
    col =0;
  }
  //set col value in motion
  col += 0.5;
  //color variables
  float col1 = col;
  float col2 = col + 55;
  float col3 = col + 155;
   
  //println(ampFast*2000);
  strokeWeight(5); // make stroke weight a audio reactive element
  
  //translate artwork to center of screen
  translate(width/2, height/2);
  
  //Incorporate if statements to organize the triggers of visuals
  //DRAWING WORK: for loop for each type of sin vis. seperated for comfort/organization  
  for(int i = 0; i < 5000; i++){
    if(note> 80){
    pushStyle();
      strokeWeight(random(5, 15));
      stroke(col2 +i, ampFast*2500, col3 - i, random(0, 100));
       //point(x1(t + i), y1(t + i));
    popStyle();
    }if(note<60){
    pushStyle();
    
      strokeWeight(ampFast*100);
      stroke(col1 + i, ampFast*2500, col2 + i );
      //point(x3(t + i), y3(t + i));
      
    popStyle();}
  }for(int i = 0; i < 500; i++){
    //if(onset == 1){
    //stroke(col1+i, col3, ampFast*2000 );
    //point(x2(t + i), y2(t + i) );
    //}else{
    //println((ampSlow2+ampSlow*1000));
    //strokeWeight(random(1, ampSlow2+ampSlow*600));
    //stroke(note*2+ i, note+i, ampFast*2000 );
    //point(x4(t + i), y4(t + i));
   }
  //} 
  //LINE FOR LOOP, COMBINES THE 2 POINT DRAWINGS INTO A LINE DRAWING
  for(int i = 0; i < NUM_LINES; i++){
    pushStyle();
    strokeWeight(ampFast2*50+ampFast*50);
    //IF Amp from first mic is larger play the visual reactive to mic 1 amp
    //IF amp from second mic is larger play the visual reactive to mic 2 amp
    //if they are equal play both at the same time: Mainly for setup process
    //if(ampSlow > ampSlow2){
    //stroke(col3 -i , col3 + i, note*2);
    //line(x1(t + i), y1(t + i), x2(t + i), y2(t + i) );
    //}if(ampSlow < ampSlow2){
    stroke(col+ i, col- i, note*2);
    //line(x3(t + i), y3(t + i), x4(t + i), y4(t + i) );
    //}if(ampSlow == ampSlow2){
       //stroke(col1+ i, col- i, note*2, ampFast*1000);
       line(x3(t + i), y3(t + i), x4(t + i), y4(t + i) );
       line(-x3(t + i), -y3(t + i), -x4(t + i), -y4(t + i) );
       //line(x1(t + i), y1(t + i), x2(t + i), y2(t + i) );
    }
   
  popStyle();
  //t+= (ampFast);
  //t+= (note/200);
  t+=((note/100)*ampFast);
  println((note/100)*ampFast);
}


//Maybe do IF statements to change design of work in process.

//Static visuals that appear when certain note or amp hits?

///////////////////////////////
//MIC 1 INPUTS/DESIGN CONTROL//
///////////////////////////////
float x1(float t){
  //println(floor(note/2));
  return sin(sin(sin(t / 25)) * (note/15)) * sin(t/10)*350 ;
   //return sin(sin(sin(t / 25)) * (note/3)) * sin(t/10)*200 ;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}
float y1(float t){
  return cos(t / (note/2)) * 400; //(2*(ampSlow*1000)) ;
 //THIS ONE IS DANK return cos(t / 5) * 100; //(2*(ampSlow*1000)) ;
}
float x2(float t){
  return sin(t / 5) * (500+ampSlow*5000) + sin(t) * 2;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}
float y2(float t){
  return cos(t / 20) * 500 + cos(t/12)*20;
}

///////////////////////////////
//MIC 2 INPUTS/DESIGN CONTROL//
///////////////////////////////
float x3(float t){
  return cos(t / 20) * 500 + cos(t/12)*20;
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}
float y3(float t){
  return sin(t / floor(note2/10)) * (500 + ampSlow2*1000) + sin(t) * 2;
}
float x4(float t){
  return sin(t/15)*(ampFast*1000)+ sin(t/20)* (100 + ampFast2*2000);
  //return -sin(FREQUENCY) * AMPLITUDE + sin(FREQ) * AMP;
}
float y4(float t){
  //println(note2/5);
  return cos(t/(note2/5)) * (200+ ampFast*1000);
}

//HOW TO BRING IN ONSET?
//THIS IS WHERE THE AUDIO INPUT MAGIC HAPPENS
//BRING IN OSC VARIABLES FROM SC AND NAME THEM ACCORDINGLY
void oscEvent(OscMessage theOscMessage) {
  ////////////////////
  // MIC 1 ANALYSIS //
  ////////////////////
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
  }if(theOscMessage.addrPattern().equals("1: ONSET") == true){
    //println(theOscMessage.addrPattern());
   onset = 1;
  }else{onset = 0;}
  ////////////////////
  // MIC 2 ANALYSIS //
  ////////////////////
  if(theOscMessage.addrPattern().equals("2: ampSlow") == true){
    //println(theOscMessage.get(0).floatValue());
   // println(theOscMessage.addrPattern());
    ampSlow2 = (theOscMessage.get(0).floatValue());
  }if(theOscMessage.addrPattern().equals("2: ampFast") == true){
    //println(theOscMessage.get(0).floatValue());
    //println(theOscMessage.addrPattern());
    ampFast2 = (theOscMessage.get(0).floatValue()); 
  }if(theOscMessage.addrPattern().equals("2: note") == true){
    //println(theOscMessage.addrPattern());
    note2 = (theOscMessage.get(0).floatValue());
  }
}
