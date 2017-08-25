#include <SPI.h>
#include <Ethernet.h>
#include <PubSubClient.h>
#include <dht.h>

#define DHT21_PIN 2
#define LED_PIN   3

#define ERROR_DELAY   2000
#define SUCCESS_DELAY 60000

unsigned long lastEventTime;
boolean sendMeasurementSuccess;

// Update these with values suitable for your network.
byte mac[] = { 0xDE, 0xED, 0xBA, 0xFE, 0xFE, 0xED };
IPAddress server(10, 7, 49, 163);

/**
//Uncomment if you want to set a manual IP
IPAddress ip(10, 10, 1, 2);
IPAddress localDns(10, 10, 1, 1);
IPAddress gateway(10, 10, 1, 1);
IPAddress subnet(255, 255, 255, 0);
**/

void callback(char* topic, byte* payload, unsigned int length);  // Callback function header

EthernetClient ethClient;
PubSubClient client(server, 1883, callback, ethClient);

dht DHT;

const char* cmdAnswerTopic = "/2fb0f72689c611e7bb5860f81db4b630/STELA_LED/cmdexe";
const char* payloadOn = "STELA_LED@change_state|ON";
const char* payloadOff = "STELA_LED@change_state|OFF";
const char* payloadOk = "STELA_LED@change_state|OK";
const char* payloadError = "STELA_LED@change_state|ERROR";

void setup() {
  Serial.begin(115200);
  delay(2000);

  pinMode(LED_PIN, OUTPUT);

  Ethernet.begin(mac); //DHCP (auto IP)
  //Ethernet.begin(mac, ip, localDns, gateway, subnet); //Manual IP
  printIPAddress();

  delay(1500);  //Allow the hardware to sort itself out

  lastEventTime = millis();
  sendMeasurementSuccess = false;
}

void printIPAddress() {
  Serial.print("IP address: ");
  for (byte thisByte = 0; thisByte < 4; thisByte++) {
    Serial.print(Ethernet.localIP()[thisByte], DEC);
    Serial.print(".");
  }
  Serial.println();
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.println("] ");

  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();

  if (checkPayloadEqual(payloadOn, (char*)payload, length)) {
    Serial.println("ON");
    digitalWrite(LED_PIN, HIGH);
    client.publish(cmdAnswerTopic, payloadOk);

  } else if (checkPayloadEqual(payloadOff, (char*)payload, length)) {
    Serial.println("OFF");
    digitalWrite(LED_PIN, LOW);
    client.publish(cmdAnswerTopic, payloadOk);

  } else {
    Serial.println("UNKNOWN");
    client.publish(cmdAnswerTopic, payloadError);
  }

  Serial.println("Answer sent");
}

boolean checkPayloadEqual(const char* payload, char* payloadInput, unsigned int inputPayloadLength) {
  if (strlen(payload) != inputPayloadLength) {
    return false;
  }

  for(int i = 0; i < inputPayloadLength; i++) {
    if(payload[i] != payloadInput[i]) {
      return false;
    }
  }
  return true;
}

void publishMeasurements() {
  char strHumidity[6];
  char strTemperature[6];

  char measurementPayloadBuf[40];

  int chk = DHT.read21(DHT21_PIN);
  switch (chk){
    case DHTLIB_OK:
      dtostrf(DHT.humidity, 4, 2, strHumidity);
      dtostrf(DHT.temperature, 4, 2, strTemperature);

      sprintf(measurementPayloadBuf, "h|%s|t|%s", strHumidity, strTemperature);
      Serial.println(measurementPayloadBuf);

      client.publish("/2fb0f72689c611e7bb5860f81db4b630/STELA_DHT/attrs", measurementPayloadBuf);

      Serial.println("Mesurement sent!");
      sendMeasurementSuccess = true;
      break;

    default:
      Serial.println("Failed to read sensor. Trying again later.");
      sendMeasurementSuccess = false;
      break;
  }
  lastEventTime = millis();
}

void reconnect() {
  while (!client.connected()) {
    Serial.println("Connecting to server...");
    if (client.connect("arduinoClient")) {
      Serial.println("Connected!");

      Serial.println("Subscribing LED command topic...");
      if(client.subscribe("/2fb0f72689c611e7bb5860f81db4b630/STELA_LED/cmd")) {
        Serial.println("Successfully subscribed to topic!");
      } else {
        Serial.println("Error while subscribing to topic.");
      }
    } else {
      Serial.println("Connection failed. Trying again in 2 seconds.");
      delay(2000); // Wait until try again
    }
  }
}

void loop() {
  if (client.connected()) {
    unsigned long currentTime = millis();
    unsigned long elapsedTime = abs(currentTime - lastEventTime);

    if ((sendMeasurementSuccess == true && elapsedTime >= SUCCESS_DELAY)
        || (sendMeasurementSuccess == false && elapsedTime >= ERROR_DELAY)) {
      publishMeasurements();
    }
    client.loop();
  } else {
    reconnect();
  }
  client.loop();
}
