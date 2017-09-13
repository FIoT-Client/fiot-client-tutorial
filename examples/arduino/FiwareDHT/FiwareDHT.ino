
//NOTA: os valores atribuidos neste exemplo devem ser alterados seguindo a aplicação desejada pelo usuário e o padrão especificado

#include <SPI.h>
#include <Ethernet.h>
#include <PubSubClient.h>
#include <DHT.h>

//bibliotecas necessárias para a aplicação, nas quais a bibliotecas que não vem na instalação do Arduino podem ser encontradas nesses links:
// DHT = https://github.com/adafruit/DHT-sensor-library
// PubSubClient = https://github.com/knolleary/pubsubclient

//definindo pinos para o LED e para o sensor
#define DHT21_PIN 2
#define LED_PIN   3


//definindo na biblioteca DHT o tipo de sensor que vai ser utilizado
#define DHTTYPE DHT21   // AM2301 

//definindo tempos de Delay para a conexão com o servidor, e o tempo entre medições
#define ERROR_DELAY   2000
#define SUCCESS_DELAY 300000 


//criando variáveis para armazenar o tempo que passou desde o ultimo evento
unsigned long lastEventTime;
boolean sendMeasurementSuccess;

// definição do endereço MAC, deve ser alterada com os valores adequados à conexão do usuário
byte mac[] = { 0xDE, 0xED, 0xBA, 0xFE, 0xFE, 0xED };

//definição do endereço IP do servidor
IPAddress server(10, 7, 49, 163);

/**
//Retirar comentários caso queira atribuir manualmente seu endereço IP
IPAddress ip(10, 10, 1, 2);
IPAddress localDns(10, 10, 1, 1);
IPAddress gateway(10, 10, 1, 1);
IPAddress subnet(255, 255, 255, 0);
**/

// Header da função callback
void callback(char* topic, byte* payload, unsigned int length);  

//instanciamento das classes EthernetClient, PubSubClient e DHT
EthernetClient ethClient;
PubSubClient client(server, 1883, callback, ethClient);
DHT dht(DHT21_PIN, DHTTYPE);

// criação de variáveis constantes para envio de comandos para o dispositivo 

const char* cmdAnswerTopic = "/cd2fda18947911e7a694fc15b4d94103/STELA_DHT/cmdexe"; // essa atribuição é feita seguindo o padrão "/API_KEY/ID_DEVICE/cmdexe"
const char* payloadOn = "STELA_DHT@change_state|ON";// essa atribuição é feita seguindo o padrão "ID_DEVICE@ACTION_NAME|RESULT"
const char* payloadOff = "STELA_DHT@change_state|OFF";// essa atribuição é feita seguindo o padrão "ID_DEVICE@ACTION_NAME|RESULT"
const char* payloadOk = "STELA_DHT@change_state|OK";// essa atribuição é feita seguindo o padrão "ID_DEVICE@ACTION_NAME|RESULT"
const char* payloadError = "STELA_DHT@change_state|ERROR";// essa atribuição é feita seguindo o padrão "ID_DEVICE@ACTION_NAME|RESULT"

void setup() {
  Serial.begin(115200); //inicia a porta serial, para fazer o monitoramento das medições via o monitor serial do Arduino
  delay(2000);
  pinMode(LED_PIN, OUTPUT);

  Ethernet.begin(mac); //DHCP (auto IP)
  //Ethernet.begin(mac, ip, localDns, gateway, subnet); //Manual IP
  printIPAddress();

  delay(1500);  //Allow the hardware to sort itself out

  lastEventTime = millis();
  sendMeasurementSuccess = false;
}

//imprime no monitor serial o endereço IP do cliente

void printIPAddress() {
  Serial.print("IP address: ");
  for (byte thisByte = 0; thisByte < 4; thisByte++) {
    Serial.print(Ethernet.localIP()[thisByte], DEC);
    Serial.print(".");
  }
  Serial.println();
}

//checa o payload e envia comandos ao dispositivo de acordo com o payload
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

//envia a medição feita pelo dispositivo para o banco de dados

void publishMeasurements() {
  char strHumidity[6];
  char strTemperature[6];

  char measurementPayloadBuf[40];

  int chk = dht.read(DHT21_PIN);
  switch (chk){
    case true:
      dtostrf(dht.readHumidity(), 4, 2, strHumidity);
      dtostrf(dht.readTemperature(), 4, 2, strTemperature);

      sprintf(measurementPayloadBuf, "h|%s|t|%s", strHumidity, strTemperature);
      Serial.println(measurementPayloadBuf);

      client.publish("/cd2fda18947911e7a694fc15b4d94103/STELA_DHT/attrs", measurementPayloadBuf); 
   //comando feito usando o padrão publish("/API_KEY/ID_DEVICE/attrs", "ATTR_01|VAL_01|ATTR_02|VAL_02")

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

//tenta fazer a conexão com o servidor, caso ocorra uma falha de conexão
void reconnect() {

  
  while (!client.connected()) {
    Serial.println("Connecting to server...");
    if (client.connect("arduinoClient")) {
      Serial.println("Connected!");

      Serial.println("Subscribing LED command topic...");
      if(client.subscribe("/cd2fda18947911e7a694fc15b4d94103/STELA_DHT/cmd"))  
      
      {
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
