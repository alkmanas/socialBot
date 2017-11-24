/*
A little example using the classic "Eliza" program.
 
 Eliza was compiled as a Processing library, based on the
 java source code by Charles Hayden:
 htp://www.chayden.net/eliza/Eliza.html
 
 The default script that determines Eliza's behaviour can be 
 changed with the readScript() function.
 Intructions to modify the script file are available here:
 http://www.chayden.net/eliza/instructions.txt
 */

import codeanticode.eliza.*;
import guru.ttslib.*;

TTS tts;

Eliza eliza;
PFont font;
String elizaResponse, humanResponse;
boolean showCursor;
int lastTime;

void setup() {
  //size(900, 900);
  fullScreen(1);

  tts = new TTS();

  // When Eliza is initialized, a default script built into the
  // library is loaded.
  eliza = new Eliza(this);

  // A new script can be loaded through the readScript function.
  // It can take local as well as remote files. 
  eliza.readScript("data/eliza.script");
  //eliza.readScript("http://chayden.net/eliza/script");

  // To go back to the default script, use this:
  //eliza.readDefaultScript();
  String[] fontList = PFont.list();

  printArray(PFont.list());
  font = createFont(fontList[300],30);
  textFont(font);

  printElizaIntro();
  humanResponse = "";
  showCursor = true;
  lastTime = 0;
}
void draw() {
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  text(elizaResponse, width/4, 50, width/2, height/2);

  fill(125);
  int t = millis();
  if (t - lastTime > 200) {
    showCursor = !showCursor;
    lastTime = t;
  }

  if (showCursor) text(humanResponse + "_", 10, 150, width - 40, height);
  else text(humanResponse+ "  ", 10, 150, width - 38, height);
}

void keyPressed() {
  if ((key == ENTER) || (key == RETURN)) {
    println(humanResponse);
    elizaResponse = eliza.processInput(humanResponse);
    println(">> " + elizaResponse);
    humanResponse = "";
    tts.speak(elizaResponse);
  } else if ((key > 31) && (key != CODED)) {
    // If the key is alphanumeric, add it to the String
    humanResponse = humanResponse + key;
  } else if ((key == BACKSPACE) && (0 < humanResponse.length())) {
    char c = humanResponse.charAt(humanResponse.length() - 1);
    humanResponse = humanResponse.substring(0, humanResponse.length() - 1);
  }
}

void printElizaIntro() {
  String hello = "Hello.";
  elizaResponse =  " " + eliza.processInput(hello);
  println(">> " + elizaResponse);
}