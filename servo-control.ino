#include <Servo.h>

String serialData;

Servo X;
Servo YL;
Servo YU;
Servo G;

void setup() {
  X.attach(2);
  YL.attach(3);
  YU.attach(4);
  G.attach(5);
  
  Serial.begin(9600);
  Serial.setTimeout(10);
} 

void loop() {
  //we will do nothing in the loop
}

void serialEvent() {
  serialData = Serial.readString();

  X.write(parseX(serialData));
  YL.write(parseYL(serialData));
  YU.write(parseYU(serialData));
  G.write(parseG(serialData));
}

int parseX(String data) {
  data.remove(data.indexOf("YL"));
  data.remove(data.indexOf("X"), 1);
  
  return data.toInt();
}

int parseYL(String data) {
  data.remove(0, data.indexOf("YL") + 2);
  data.remove(data.indexOf("YU"));

  return data.toInt();
}

int parseYU(String data) {
  data.remove(0, data.indexOf("YU") + 2);
  data.remove(data.indexOf("G"));
  
  return data.toInt();
}

int parseG(String data) {
  data.remove(0, data.indexOf("G") + 1);
  data.remove(data.indexOf("e") + 1);

  if (data == "true") {
    return 90;  
  }

  if (data == "false") {
    return 0;  
  }
}
