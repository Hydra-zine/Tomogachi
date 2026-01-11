#include "AdafruitIO_WiFi.h"

#include <SoftwareSerial.h>

SoftwareSerial tx(10);

// 1. YOUR SECRETS (From the Yellow Key on Adafruit)
#define IO_USERNAME  "rsooknanan"
#define IO_KEY       "enter your key here"

// 2. YOUR WIFI
#define WIFI_SSID    "iPhone"
#define WIFI_PASS    "urwelcome"

AdafruitIO_WiFi io(IO_USERNAME, IO_KEY, WIFI_SSID, WIFI_PASS);

AdafruitIO_Feed *commandFeed = io.feed("espcommunicator");

void setup() {
  Serial.begin(9600);

  // Connect to Adafruit IO
  Serial.print("Connecting to Adafruit IO");
  io.connect();

  // This tells the code what to do when a message arrives
  commandFeed->onMessage(handleMessage);

  // Wait for connection
  while(io.status() < AIO_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println("\nConnected!");
}

void loop() {
  // Keeps the connection alive
  io.run();
}

// 4. THE ACTION
void handleMessage(AdafruitIO_Data *data) {
  String rcvdData = data->toString(); 
  Serial.println(rcvdData);
  tx.println(rcvdData);
}


