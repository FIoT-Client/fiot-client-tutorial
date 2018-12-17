**************************************************
FIoT-Client's installation and use Tutorial
**************************************************

.. contents::
   :local:
   :depth: 3


.. _autores:

Authors
=======


Authors:

-  `Carlos Eduardo da Silva (Advisor)  <https://projetos.imd.ufrn.br/kaduardo>`__ -> `Contact <kaduardo@imd.ufrn.br>`__
-  `Lucas Cristiano Calixto Dantas <https://github.com/lucascriistiano>`__ -> `Contact <lucascristiano27@gmail.com>`__
-  `Lucas Ramon Bandeira da Silva <https://github.com/lucasramon>`__ -> `Contact <lucas.ramon.jc@gmail.com>`__



.. _introducao:

Introduction
====================


.. begin-conceituacaoTeorica

Theoretical Concepts
--------------------

The `FIWARE <https://www.fiware.org>`__ platform presents an enviroment based on the cloud computing platform `OpenStack <https://www.openstack.org>`__ with some changes and the addition of other components. It presents a set of standardized APIs that make the communication with the Internet of Things (IoT) and manipulating context information easier. It facilitates the analysis of big sets of data and the provision of real time average, making real time events analysis, information gathering from sensors, action on actuators easier. 


that set of functionalities are grouped in the form of chapters, and each chapter is made by a set of GEs (generic enablers), being this the name of each component in the platform.

About the IoT applications, the platform offers GES that allows that "things" become context resources that are available, searchable, accessible and usable, making possible the interaction of Fiware Apps with real world objects. The "things" can represent any phisical object, living being, person or concept of interest from the perspective of a application, and their parameters are totally or partially bound to sensors, actuators (or a combination of both of them).


Some important concepts that are important to know to use this tutorial are listed below.

**Device:** Also Known as IoT end-node, they are a hardware, component or system entity. They are designated for measure or influence the properties of a thing, or a group of things. Sensors and actuators are examples of devices.

**IoT End-Node:** this term is used in the documentation for complex phisical devices with many sensors and actuators, like an Arduino based system, for example. Devices can use standardized or proprietary communication protocols, that can be natively send for the backend GEs or translated in other standardized or proprietary protocol in the IoT gateways, like the conversion of that specific protocol for the OMA NGSI, that can be made in the FIWARE GEs, for example. An Arduino or Raspberry pi are examples of IoT End-Nodes.

**IoT Resource:** The tern refers to a computational element that provides acess to sensors/actuators devices. An information model for the description of IoT resources can include context information like precision, localization, status information, etc. IoT resource data level consists not only in the measured data itself, but also context information, like the type of data, a time instant, etc. IoT resoruces can be addressed using an uniform addressing scheme and they are usually hosted in the device but also presentes a logical representation in the backend.

**Thing:** this term can refer to any object, person or place in the real world. they are represented as virtual things and each representation has an entity ID, one typer and diverses attributes. Sensors can be modeled as virtual things, but things in the real world, either concrete or abstract also can be modeled as virtual things. Data at level of things consists of things description and their attributes, it may also be informations about how the data was obtained through metadata.


**NGSI Context-Entity:** IoT End-Nodes, IoT resources and "things" are represented as NGSI context entities in the GE data chapter context broeker, therefore developers need to learn just the same API of that GE, used for context information, as well to manage information of IoT applications. The informations of measures of sensors can be obtained through reading of the attributes of these entities.

**Service and Service-Path:** They are used to defne the utilized scope for the execution of requests and opertations, making the required operations are perfomed over devices and entities with given unique inside a specific scope, located together with the values of the Service and Service-path defined at the moment of the register of a device and when it sends a measure.


.. end-conceituacaoTeorica



.. _ambienteInstalacao:

Installing the environment
==========================

The environment are made by two components: the backend using Docker, and the frontend using the FIoT-Client.


Installing the backend: Docker
-------------------------------

.. begin-docker

In order to prepare the environment for the execution of this tutorial, first we need to run the GEs that will be necessary for the creations of the IoT Applications using the FIWARE. For that purpose, was planned the architecture presented in the Figure 01, composed by the main needed components for the creation of the applications that uses context and IoT manipulation resources on the platform.

.. image:: https://github.com/FIoT-Client/fiot-client-tutorial/blob/master/extras/fiware_components_deploy.png
Figure 01 - Architecture of the selected Fiware components for this tutorial.

In the picture above it is possible to identify components resposible for the communication with the devices (IDAS), context Information storage and manipulation (Orion Context Broker), communications with databases for storing measurements (Cygnus) and the databases used for perform that persistence, and for the execution of this tutorial were chosen a *MySQL* adn a *MongoDB* Databases, and in addition it was used the FIWARE component responsible for storage historical data, making possible the storage and query of aggregate historical data (STH Comet).

To create the environment composed by all these components, it was used `Docker <https://www.docker.com>`__, that allows from available images of the selected FIWARE components, can be possible to define configuration parameters and the way that communication between theses components will occur.

Note: in case that already exists a configured and available envirnoment that presents the components cited on the image, it is possible to skip the next steps to configure the environment in your setup.

First it is necessary to install Docker in your setup, the tutorial to install Docker can be found on this `link <https://www.docker.com/get-docker>`__.

Also is necessary to install the tool called docker-compose, that will make possible that the environment composed by all the selected components can be easily executed. the tutorial to install docker-compose can be found on this `link <https://docs.docker.com/compose/install>`__.

After you had correctly installed the Docker and the Docker-compose, you are ready to run the environment. For this, you have to acess the directory in which the repository was cloned, there is a file named `docker-compose.yml <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/deploy/full/docker-compose.yml>`__, and in your terminal you must execute the following command: ::

$ docker-compose up -d

This command will execute all the needed components for the execution of this tutorial.

To check if the environment was configured and it's running correctly, open your browser and type "localhost:1026/version" and it will be returned a *JSON* showing the version of the Orion component in execution. 


.. end-docker

Installing the frontend : FIoT-Client-Python 
---------------------------------------------

Virtual Environment Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

First, it must be created a directory where the environment will be installed, and then acess it ::

$ mkdir my-directory
$ cd my-directory


After the directory is created, it's created a Python virtual environment ::

$ python -m venv .my-environment

To activate it, we use the source command ::

$ source .my-environment/bin/activate


With the virtual environment created, the installation of iPython is done ::

$ (.my-environment) pip install ipython


Installing the FIoT-Client library
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For install the library, it's used the command ::

$ (.my-environment)  pip install -e git+https://github.com/FIoT-Client/fiot-client-python.git#egg=fiotclient


In order to test if the installation was made correctly, we use the python import command :: 

$ (.my-environment) ipython
>>> from fiotclient import iot


Installing the frontend: GUI Web
----------------------------------

.. begin-GUI

Under Construction!

.. end-GUI

.. _registrarDispositivo:

Registering a device
==========================

Using FIoT-Client
------------------

Registering the device on Fiware
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


.. begin-FIoTClient-register

Configure the configuration file (config.ini)
"""""""""""""""""""""""""""""""""""""""""""""""

To start the register of the device, first we need to create a configuration file, in order to make things simple, there is a pre-programmed file on this `repository <https://github.com/FIoT-Client/fiot-client-tutorial/blob/master/config.ini>`__, which from him the user can change the values of the addresses of the components of which will be used.



Creation of the service and the Service Path
""""""""""""""""""""""""""""""""""""""""""""
After you finish the configuration of the config.ini, the next step is the creation of the Service and the Service Path, using the fiotclient library ::

$ (.my-environment) ipython
>>> from fiotclient import iot #imports the library 'fiotclient'
>>> client_iot = iot.FiwareIotClient('config.ini') #configure the components using the config.ini
>>> client_iot.create_service('SERVICE_NAME', '/SERVICE_PATH') #create the service, defining your name and path


note: the path of the service must be preceded by a slash '/' and cannot contain certain special characters like the underscore ('_').

After the creation of the service, it will be a confirmation message, with a string, that must be maintained together with the name of the service and with the service path, to be used together when a new device is registered. The confirmation message is displayed this way: :: 


{"status_code": 201,"api_key": 'API_KEY'}


Registering the device
"""""""""""""""""""""""""
For register a new device, first we must set in which service and service path he will be bound, and that is done by using the following command: ::


>>> client_iot.set_service('SERVICE_NAME', '/SERVICE_PATH')

Using the values stored before. The next step is to assign the API_KEY to device, using the command: ::

>>> client_iot.set_api_key('API_KEY')

After you done all the assignments, the next step is to register the device, and this is done by a JSON format file, and some example of devices are available on this `repository <https://github.com/FIoT-Client/fiot-client-tutorial/tree/master/examples/devices>`__.

It's recommended that the device files are saved in the same directory as your application is running.

Lastlym to register the device, its used the following command: ::

>>> client_iot.register_device('DEVICE_DIRECTORY', 'ID_DEVICE', 'ID_ENTITY')

The arguments of this function are the directory in which it is sabed the device file, the id of the device, and the entity id in which the device is related. All these values are in the device JSON file.

For listing the device that are registered on this Service, it is used the following command::


>>> client_iot.list_devices()

After you're done, the next step is the configuration of the entity that will be related with the device(s) of the application.


Setting up Storage (registering databases in the Orion)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Entity's creation
"""""""""""""""""""

For the creation of the entity, first we need to import the methods related to the entity's API acess module, located in the fiotclient library, after that we must configure the components of the entity using the config.ini file. That steps are done through the following commands: ::

>>> from fiotclient import context
>>> client_context = context.FiwareContextClient('config.ini')

After done that, now it's done the assignment of the entity to the desired Service and Service Path, using the following command: ::

>>> client_context.set_service('SERVICE_NAME', '/SERVICE_PATH')

In order to check the informations about this entity, we use the command: ::

>>> client_context.get_entity_by_id('ID_ENTITY')


Connecting the entity with Cygnus
""""""""""""""""""""""""""""""""""

To connect the entity with Cygnus, the following command is used: ::

>>> client_context.subscribe_cygnus('ID_ENTITY', ['ATTR_01', ...])

The attributes of the function are the entity's id that is designated to connect with the Cygnus, and the device attributes.

After this, it's possible to send the collected data by the devices to a database, that database can be a MySQL, MongoDB, etc.

Lastly, to send and storage the historical data, we use the following command: ::

>>> client_context.subscribe_historical_data('ID_ENTITY', ['ATTR_01', ...])


Usando o WEB GUI
----------------

.. begin-WEB GUI-Register

Under Construction!

.. end-WEB GUi-Register


.. _programandoDispositivo:


Programming a device
==========================

Arduino
-------

.. begin-programming-Arduino

On this example, it was used a DHT21 AM2301 temperature and humidity sensor, and the file can be found on this `link <https://github.com/FIoT-Client/fiot-client-tutorial/blob/master/examples/arduino/FiwareDHT/FiwareDHT.ino>`__.


.. end-programming-Arduino


Raspberry Pi
------------

.. begin-programming-RaspberryPi
On this example, it was used a DHT22 AM2302 temperature and humidity sensor, and the file can be found on this `link <https://github.com/FIoT-Client/fiot-client-tutorial/blob/master/examples/example_DHT2302.py>`__.

.. end-programming-RaspberryPi

.. _visualizeData:

Visualizing the generated data
==============================


Using Web Gui
--------------

.. begin-visualize-GUI


Under construction!

.. end-visualize-GUI

Database Query
---------------


.. begin-visualize-Database

Under construction!


.. end-visualize-Database

Mysql
-----

.. begin-visualize-mysql

At the moment that the service is created, it's created a database with the same name used at the moment of the register, but with lowecase letters. For each registered entity it's also created in the respective service, a table in the format "SERVICE_PATH" + "_" + "ENTITY_ID" + "_" + "ENTITY_TYPE".

To acess the database that is being used in the Service its used the command:


.. code-block:: sql
   

   use NAME_DATABASE

Where 'NAME_DATABASE' must be replaced by the name of the created database for the service.

To check all registered data in an entity is used the command:


.. code-block:: sql
   

 SELECT * FROM ENTITY_TABLE

 Where 'ENTITY_TABLE' must be replaced by the name of the created table for the entity.


.. end-visualize-mysql

MongoDB
-------

.. begin-visualize-mongoDB


Under construction!

.. end-visualize-mongoDB

ELK
---

.. begin-visualize-ELK

Under construction!

.. end-visualize-ELK

Query Orion
-----------------

.. begin-visualize-Orion


Under construction!

.. end-visualize-Orion
