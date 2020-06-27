import processing.serial.*;

Serial myPort;

int lastTimeCheck;
int timeIntervalFlag = 10; 

int X = 0;
int YL = 0;
int count = 0;
int YU = 0;
boolean G = false;

String output = "X" + X + "YL" + YL + "YU" + YU + "G" + G;

void setup() {
  size(200, 200);
  String portName = Serial.list()[0]; //Change to the correct com index
  myPort = new Serial(this, portName, 9600);
  
  lastTimeCheck = millis();
}

void draw() {
  if ( millis() > lastTimeCheck + timeIntervalFlag ) {
    lastTimeCheck = millis();
    myPort.write(output);
  }
}

void mouseMoved() {
  X = int(map(mouseX, 0, width, 0, 180));
  YL = int(map(mouseY, 0, height, 0, 180));
  G = false;
  
  output = "X" + X + "YL" + YL + "YU" + YU + "G" + G;
}
void mouseDragged() {
  X = int(map(mouseX, 0, width, 0, 180));
  YL = int(map(mouseY, 0, height, 0, 180));
  G = true;
  
  output = "X" + X + "YL" + YL + "YU" + YU + "G" + G;  
}

void mousePressed() {
  G = true;
  
  output = "X" + X + "YL" + YL + "YU" + YU + "G" + G;
}

void mouseReleased() {
  G = false;
  
  output = "X" + X + "YL" + YL + "YU" + YU + "G" + G;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  
  if (e == 1) {
    count++;    
  }
  
  if (e == -1) {
    count--;
  }
  
  YU = int(map(constrain(count, 0, 20), 0, 20, 0, 180));
  output = "X" + X + "YL" + YL + "YU" + YU + "G" + G;
}
