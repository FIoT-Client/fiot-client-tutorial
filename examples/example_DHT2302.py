import sys
import time

#biblioteca necessária para a leitura do sensor AM2302 utilizado no exemplo, disponível em:
#https://github.com/adafruit/Adafruit_Python_DHT
import Adafruit_DHT


import fiotclient
from fiotclient.context import FiwareContextClient
from fiotclient.iot import FiwareIotClient

if __name__ == '__main__':
    arguments = []
    if len(sys.argv) > 1:
        arguments = sys.argv


    
    #definição do diretório do dispositivo
    DEVICE_FILE_ROOT = "/home/pi/exemploFiware/"
 
    #definição do nome do Service
    SERVICE_NAME ='RaspberryPiUFRNStela'

    #definição do nome do Service Path
    SERVICE_PATH ='/RaspberryDHTStela'

    #definição da api_key gerada na criação do service
    API_KEY = '250e10409ada11e7b137b827eb1df5b0'
 
    #id do dispositivo que se deseja enviar medições
    DHT_DEVICE_ID = "STELA_DHT"
 
    #id da entidade que está ligada ao dispositivo
    DHT_ENTITY_ID = "01" 

    #dispositivo que vai ser utilizado na aplicação
    Device = "DHT.json" 
    
    #diretório completo do dispositivo 
    DHT_FILE_PATH = DEVICE_FILE_ROOT + Device
 
    #definição do sensor utilizado
    sensor = Adafruit_DHT.AM2302

    #definição do pino GPIO utilizado no Raspberry pi   
    GPIOpin = '4'

    #definição do tempo entre medições
    DELAY_MEASUREMENT = 10 

    #criando uma instância das classes iot e context da biblioteca fiotclient
    client_iot = FiwareIotClient("config.ini")
    client_context = FiwareContextClient("config.ini")
    
    
    #atribuindo o service e o service path
    if '--no-set-service' not in arguments:
        client_iot.set_service(SERVICE_NAME, SERVICE_PATH)

    #atribuindo a api_key
    if '--no-set-api-key' not in arguments:    
        client_iot.set_api_key(API_KEY)

    #registrando o dispositivo
    if '--no-register-device' not in arguments:
        client_iot.register_device(DHT_FILE_PATH, DHT_DEVICE_ID, DHT_ENTITY_ID)

    #atribuindo a entidade
    if '--no-set-service' not in arguments:
        client_context.set_service(SERVICE_NAME, SERVICE_PATH)
    
    #fazendo a inscrição no cygnus, usando os argumentos (Entity_ID,[attrs..])    
    if '--no-subscribe-cygnus' not in arguments:
        client_context.subscribe_cygnus(DHT_ENTITY_ID, ["humidity","temperature"])

    #fazendo a inscrição para histórico de dados, usando os argumentos (Entity_ID,[attrs..]) 
    if '--no-subscribe-sth' not in arguments:
        client_context.subscribe_historical_data(DHT_ENTITY_ID, ["humidity","temperature"])

    try:
        while True:
            #leitura do sensor AM2302, utilizado neste exemplo
            humidity, temperature = Adafruit_DHT.read_retry(sensor, GPIOpin)

            #envio da medição ao servidor, usando os argumentos ('ID_DEVICE', {'ATTR_01': VAL_01,'ATTR_02': 'VAL_02'},protocol='PROTOCOL')       
            client_iot.send_observation(DHT_DEVICE_ID, {'humidity': humidity,'temperature':temperature}, protocol='MQTT')
            
            print("measurement sent!")
            time.sleep(DELAY_MEASUREMENT)
    except KeyboardInterrupt:
        pass
