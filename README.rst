**************************************************
Tutorial de instalação e utilização do FIoT-Client
**************************************************

.. contents::
   :local:
   :depth: 3


.. _autores:

Autores
=======


Autores:

-  `Carlos Eduardo da Silva (Orientador)  <https://projetos.imd.ufrn.br/kaduardo>`__ -> `Contato <kaduardo@imd.ufrn.br>`__
-  `Lucas Cristiano Calixto Dantas <https://github.com/lucascriistiano>`__ -> `Contato <lucascristiano27@gmail.com>`__
-  `Lucas Ramon Bandeira da Silva <https://github.com/lucasramon>`__ -> `Contato <lucas.ramon.jc@gmail.com>`__



.. _introducao:

Introdução
====================


.. begin-conceituacaoTeorica

Conceituação Teórica
--------------------

A plataforma `FIWARE <https://www.fiware.org>`__ apresenta um ambiente baseado na plataforma de computação em nuvem `OpenStack <https://www.openstack.org>`__ com algumas modificações bem como com a adição de outros componentes. Ela apresenta um conjunto de APIs padronizadas que, entre outras coisas, torna mais fácil realizar a comunicação com a Internet das Coisas (IoT) e manipulação de informações de contexto. Ela facilita  análises sobre grandes volumes de dados e fornecimento de médias em tempo real, trazendo facilidades para manipulação de informações de contexto, análise de eventos em tempo real, coleta de informações a partir de sensores e ação sobre atuadores, controle de acesso, entre tantas outras funcionalidades.

Esses conjuntos de funcionalidades são agrupados na plataforma em forma de capítulos, sendo cada um deles composto por um conjunto de GEs (Generic Enablers), nomenclatura dada a componentes dentro da plataforma.

Em relação a aplicações IoT, a plataforma fornece GEs que permitem que "coisas" se tornem recursos de contexto disponíveis, pesquisáveis, acessíveis e utilizáveis, possibilitando a interação de Apps FIWARE com objetos do mundo real. As "coisas" representam qualquer objeto físico, organismo vivo, pessoa ou conceito de interesse a partir da perspectiva de uma aplicação e seus parâmetros são totalmente ou parcialmente atrelados a sensores, atuadores (ou uma combinação desses). A plataforma ajuda a abstrair a complexidade e alta fragmentação de tecnologias IoT e de cenários de implantação.


Entender alguns conceitos é fundamental para a utilização das APIs FIWARE e, consequentemente, ferramentas que façam uso dessas. Logo, abaixo serão definidos alguns conceitos que facilitam a compreensão do que será apresentado durante esse tutorial.

**Dispositivo (Device):** Também conhecido como nó-fim IoT (IoT end-node), diz respeito a uma entidade de hardware, componente ou sistema. Ele é respnsável por medir ou influenciar as propriedades de uma coisa/grupo de coisas (ou ambas, concorrentemente). Sensores e atuadores são exemplos de dispositivos.

**Nó-Fim IoT (IoT End-Node):** O termo é usado na documentação para dispositivos físicos complexos com diversos sensores e atuadores, como, por exemplo, um sistema complexo baseado em Arduino. Dispositivos podem usar protocolos de comunicação padronizados ou proprietários, que podem ser enviados nativamente para os GEs de Backend ou traduzidos em outro protocolo padronizado ou proprietário nos Gateways IoT, como a conversão desses protocolos específicos para OMA NGSI que pode ser realizada em GEs FIWARE, por exemplo. Um Arduino ou Raspberry Pi são exemplos de IoT End-Nodes.

**Recurso IoT (IoT Resource):** Refere-se a um elemento computacional que provê acesso a dispositivos sensores/atuadores. Um modelo de informação para a descrição de recursos IoT pode incluir informações de contexto, como, por exemplo, localização, precisão, informação de status, etc. Dados a nível de recursos IoT consistem não apenas no dado medido, mas também informação de contexto, como tipo de dado, um instante de tempo, precisão da medição e o sensor a partir do qual a medição foi realizada, etc. Recursos IoT podem ser endereçados usando um esquema de endereçamento uniforme e são geralmente hospedados no dispositivo mas também apresentam uma representação lógica no backend.

**Coisa (Thing):** Diz respeito a qualquer objeto, pessoa ou lugar no mundo real. São representadas como coisas virtuais e, em sua respresentação, possuem um ID de entidade, um tipo e diversos atributos. Sensores podem ser modelados como coisas virtuais, porém, coisas do mundo real, sejam essas concretas ou abstratas, (como quartos, pessoas, grupo, etc.), também podem ser modelados como coisas virtuais. Dados a nível de coisas consistem de descrições das coisas e seus atributos, podendo constar também informações sobre como os dados foram obtidos através de meta  dados.

**Entidade de Contexto NGSI (NGSI Context-Entity):** IoT End-Nodes, Recursos IoT e "Coisas" são representados como Entidades de Contexto NGSI no GE Context Broker do capítulo de dados, logo desenvolvedores precisam aprender apenas a mesma API dessa GE, utilizada para informações de contexto, para também gerenciar informações de aplicações IoT. As informações de medições de sensores pode ser obtida através da leitura de atributos dessas entidades, enquanto o acionamento de comandos em atuadores pode ser feita a partir da atualização em atributos específicos que representam comandos nessas.

**Service e Service-Path:** São utilizados para definir o escopo utilizado para a execução de requisições e operações, fazendo com que as operações necessárias sejam realizadas sobre dispositivos e entidades com determinados IDs únicos dentro de um escopo específico, localizados juntamente com os valores do Service e Service-Path definidos no momento do registro e envio de medições a dispositivos.

.. end-conceituacaoTeorica



.. _ambienteInstalacao:

Instalação do ambiente
======================

O ambiente é formado por dois componentes: o back-end utilizando Docker, e o front-end utilizando o FIoT-Client.


Instalando o back-end: Docker
-----------------------------

.. begin-docker

Para preparar o ambiente para a execução do tutorial, precisamos primeiro rodar os GEs que serão necessários para a criação de aplicações IoT utilizando o FIWARE. Para isso, foi planejada a arquitetura apresentada na figura abaixo, composta pelos principais componentes necessários para criação de aplicações que usem recursos de manipulação de contexto e IoT na plataforma.

.. image:: https://github.com/FIoT-Client/fiot-client-tutorial/blob/master/extras/fiware_components_deploy.png
Figura 01 - Arquitetura dos componentes FIWARE selecionados para o tutorial


Nela é possível identificar componentes responsáveis pela comunicação com dispositivos (IDAS), armazenamento e manipulação de informações de contexto (Orion Context Broker), comunicação com bases de dados para armazenamento de medições (Cygnus) e as próprias bases de dados utilizadas para realizar essa persistência, tendo sido escolhidos para a execução do tutorial um banco de dados *MySQL* e um *MongoDB*, além do componente FIWARE responsável pelo armazenamento de dados históricos, possibilitando o armazenamento e consulta de dados históricos agregados (STH Comet).

Para criar o ambiente composto por todos esses componentes foi utilizada a ferramenta `Docker <https://www.docker.com>`__, que permite que, a partir de imagens disponibilizadas dos componentes FIWARE selecionados, seja possível definir parâmetros de configuração bem como a forma como ocorrerá a comunicação entre esses componentes e o modo que esses estarão acessíveis para uso por aplicações.

OBS: Caso já exista um ambiente configurado e disponível que apresenta os componentes utilizados pelo tutorial e apresentados na imagem acima, é possível pular os passos seguintes para configuração do ambiente em sua máquina.

Inicialmente é necessário realizar a instalação do Docker em sua máquina, caso já não o tenha instalado. Os passos para a instalação em seu sistema operacional pode ser acessado no `link <https://www.docker.com/get-docker>`__.

Também é necessário instalar a ferramenta docker-compose, que possibilitará que o ambiente composto por todos os componentes selecionados possa ser facilmente executado. Os passos para a instalação podem ser acessados no `link <https://docs.docker.com/compose/install>`__.

Tendo instalado corretamente o Docker e o docker-compose, você está pronto para rodar o ambiente. Para isso, você deverá acessar o diretório no qual o repositório de tutorial foi clonado, no qual existe um arquivo chamado `docker-compose.yml <https://github.com/FIoT-Client/fiot-client-tutorial/blob/master/deploy/full/docker-compose.yml>`__, e, a partir da linha de comando do seu sistema operacional, executar o comando: ::

$ docker-compose up -d

Esse comando executará todos os componentes necessários para a execução do tutorial e, caso nenhuma mensagem de erro tenha sido exibida, deverá estar executando corretamente.

Para testar se o ambiente foi configurado e está sendo executado corretamente, abra o seu navegador e acesse o endereço localhost:1026/version e deverá ser retornado um *JSON* apresentando a versão do componente Orion em execução.



.. end-docker

Instalando o front-end : FIoT-Client-Python 
---------------------------------------------

Configuração do ambiente virtual
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Para começar, deve ser criado um diretório onde ficará o ambiente instalado, e acessá-lo ::

$ mkdir meu-diretorio
$ cd meu-diretorio

Após a criação do diretório, é criado um ambiente virtual Python ::

$ python3 -m venv .meu-ambiente

Para ativá-lo, usamos o comando source ::

$ source .meu-ambiente/bin/activate

Com o ambiente virtual já criado, é feita a instalação do iPython ::

$ (.meu-ambiente) pip install ipython


Instalação da biblioteca FIoT-Client
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Para a instalação da biblioteca, é usado o comando ::

$ (.meu-ambiente) pip install -e git+https://github.com/FIoT-Client/fiot-client-python.git#egg=fiotclient


E para testar se a instalção foi feita corretamente, fazemos o comando de import do Python ::


$ (.meu-ambiente) ipython
>>> from fiotclient import iot


Instalando o front-end: GUI Web
----------------------------------

.. begin-GUI

Em breve!

.. end-GUI

.. _registrarDispositivo:

Registrando um dispositivo
==========================

Usando FIoT-Client
------------------

Registrando o dispositivo no Fiware
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


.. begin-FIoTClient-register

Configurar arquivo de configuração (config.ini)
"""""""""""""""""""""""""""""""""""""""""""""""

Para iniciar o registro do dispositivo, primeiro devemos criar um arquivo de configuração, porém para facilitar o andamento do tutorial, há um arquivo 
pré-programado de configuração neste `repositório <https://github.com/FIoT-Client/fiot-client-tutorial/blob/master/config.ini>`__,
no qual a partir dele o usuário pode alterar os valores dos endereços dos componentes dos quais ele irá utilizar.



Criação do service e do Service Path
""""""""""""""""""""""""""""""""""""

Após a configuração do config.ini, o próximo passo  é a criação do Service e do Service Path, utilizando a biblioteca fiotclient instalada anteriormente. ::

$ (.meu-ambiente) ipython
>>> from fiotclient import iot #importa a biblioteca 'fiotclient'
>>> client_iot = iot.FiwareIotClient('config.ini') #configura os componentes utilizando o config.ini
>>> client_iot.create_service('SERVICE_NAME', '/SERVICE_PATH') #cria o serviço, definindo o seu nome e o seu caminho

obs: o caminho do serviço deve ser precedido de uma barra '/' e não pode conter certos caracteres especiais como por exemplo o underscore ('_').

Após a criação do serviço, haverá uma mensagem de confirmação, junto com uma string, que deve ser guardada em conjunto com o nome do Service e do seu respectivo Service Path para serem usados quando houver o registro de um dispositivo novo. A mensagem de confirmação é mostrada dessa forma: ::

{"status_code": 201,"api_key": 'API_KEY'}


Registrando o dispositivo
"""""""""""""""""""""""""

Para o registro de um novo dispositivo, primeiros devemos selecionar em qual Service e em qual Service Path ele irá ficar, no qual é feito utilizando os comando: ::

>>> client_iot.set_service('SERVICE_NAME', '/SERVICE_PATH')

Usando os valores guardados anteriormente. Com isso, o passo seguinte se dá por atribuir a API_KEY para o dispositivo, usando o comando:

  
>>> client_iot.set_api_key('API_KEY')

Depois de feita todas as atribuições, o próximo passo é registrar o dispositivo, no qual é definido por um arquivo no formato JSON, em que alguns exemplos de dispositivos podem ser encontrados neste `repositório <https://github.com/FIoT-Client/fiot-client-tutorial/tree/master/examples/devices>`__.
É recomendado que os arquivos dos disposítivos estejam salvos no mesmo diretório de onde estará rodando a aplicação.

Por fim, para registrar o dispositivo, é usado o seguinte comando: ::

>>> client_iot.register_device('CAMINHO_DEVICE', 'ID_DEVICE', 'ID_ENTITY')

tendo como argumentos o diretório em que está salvo o arquivo do dispositivo, o id do dispositivo, e o id da entidade na qual o dispositivo esta se relacionando, respectivamente. Todos estes valores estão contidos no arquivo JSON do dispositivo,.

Para listagem dos dispositivos que estão registrados neste SERVICE, utilizamos o comando: ::

>>> client_iot.list_devices()

Com isso o próximo passo é a configuração da entidade que estará se relacionando com o(s) dispositivo(s) da aplicação.

Configurando armazenamento (registrando bancos no Orion)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Criação da entidade
"""""""""""""""""""
Para a criação da entidade, devemos primeiro importar da biblioteca fiotclient os métodos relacionados ao módulo de acesso à API da entidade, após isso devemos configurar os componentes da entidade usando o arquivo config.ini, e esse passo é feito através dos comandos: ::

>>> from fiotclient import context
>>> client_context = context.FiwareContextClient('config.ini')

Feito isso, agora é feita a atribuição da entidade ao SERVICE e ao SERVICE PATH desejado, utilizando o seguinte comando: ::

>>> client_context.set_service('SERVICE_NAME', '/SERVICE_PATH')

Para checarmos as informações referentes a essa entidade, utilizamos o comando: ::

>>> client_context.get_entity_by_id('ID_ENTITY')


Conectando a entidade com o Cygnus
""""""""""""""""""""""""""""""""""

Para conectarmos a entidade com o Cygnus, uitlizamos o seguinte comando: ::

>>> client_context.subscribe_cygnus('ID_ENTITY', ['ATTR_01', ...])

Sendo os atributos o id da entidade na qual se deseja conectar com o Cygnus, e os atributos dos dispositivos .

Com isso, é possivel enviar os dados coletados pelos dispositivos para um banco de dados, podendo ser um banco no MySQL, MongoDB, etc.

E por fim, para enviar e armazenar o histórico de dados, utilizamos o seguinte comando: ::

>>> client_context.subscribe_historical_data('ID_ENTITY', ['ATTR_01', ...])


Usando o WEB GUI
----------------

.. begin-WEB GUI-Register

Em Breve!

.. end-WEB GUi-Register


.. _programandoDispositivo:


Programando um dispositivo
==========================

Arduino
-------

.. begin-programming-Arduino

Neste exemplo, foi utilizado um sensor de temperatura e umidade DHT21 AM2301, no qual o arquivo se encontra neste `link <https://github.com/FIoT-Client/fiot-client-tutorial/blob/master/examples/arduino/FiwareDHT/FiwareDHT.ino>`__.


.. end-programming-Arduino


Raspberry Pi
------------

.. begin-programming-RaspberryPi

Neste exemplo, foi utilizado um sensor de temperatura e umidade DHT22 AM2302, no qual o arquivo se encontra neste `link <https://github.com/FIoT-Client/fiot-client-tutorial/blob/master/examples/example_DHT2302.py>`__.

.. end-programming-RaspberryPi

.. _visualizeData:

Visualizando os dados gerados
=============================


Usando Web Gui
--------------

.. begin-visualize-GUI


Em Breve!

.. end-visualize-GUI

Consulta ao banco de dados
--------------------------


.. begin-visualize-Database

Em Breve!


.. end-visualize-Database

Mysql
-----

.. begin-visualize-mysql

Ao fazer a criação do Service, é criado um banco de dados com o mesmo nome utilizado no momento do cadastro, porém, todo em letras minúsculas. Para cada Entidade registrada é também criada, no banco de dados do seu respectivo serviço, uma tabela no formato "SERVICE_PATH" + "_" + "ID_ENTIDADE" + "_" + "TIPO_ENTIDADE".

Para acessar o banco que está sendo utilizado no Service é utilizado o comando: 


.. code-block:: sql
   

   use NOME_DO_BANCO_DE_DADOS

Onde 'NOME_DO_BANCO_DE_DADOS' deve ser substituído pelo nome do banco criado para o serviço.

Em seguida, selecionado o banco de dados do Service, para checar todos os dados registrados em uma entidade é utilizado o comando: 


.. code-block:: sql
   

 SELECT * FROM TABELA_DA_ENTIDADE

Onde 'TABELA_DA_ENTIDADE' deve ser substituído pelo nome da tabela criada para a entidade desejada.

.. end-visualize-mysql

MongoDB
-------

.. begin-visualize-mongoDB


Em Breve!

.. end-visualize-mongoDB

ELK
---

.. begin-visualize-ELK

Em Breve!

.. end-visualize-ELK

Consulta ao Orion
-----------------

.. begin-visualize-Orion


Em Breve!

.. end-visualize-Orion
