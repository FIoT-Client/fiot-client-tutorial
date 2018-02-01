��    X      �              �  L  �  7  �  d  "	  P  �  �  �  �  �     D  F  E  �   �  H   0  /  y     �     �     �  }   �  �   @  H   �       "   )  8   L  1   �  "   �     �     �       &     �  D  _   �  [   Z     �  	   �  	   �  f  �  �   5      �   �   �!  �   n"  ~   D#  �   �#     �$  +   �$     �$  &   %     @%     Y%     f%     n%  Q  t%  �   �'  �   �(  q   �)  �   *  ^   �*  d   U+    �+  8   �,  Q   -  *   ^-  T   �-  _   �-  K   >.  �  �.  �   0  ]   �1  �   2  �  �2  �   �4  F   �5     �5     �5     	6  #   #6     G6  n   b6    �6  �  �7  6   �9     �9     �9     �9  �   :     �:  w   �:  s   ,;  k   �;  �   <  �   �<  |  �=  L  ?  7  cA  d  �B  P   E  �  QG  �  J     �K  F  �N  �   P  H   �P  /  �P     "R     *R     2R  }   ;R  �   �R  H   AS     �S  "   �S  8   �S  1   �S  "   0T     ST     eT     �T  &   �T  �  �T  _   sV  [   �V     /W  	   3W  	   =W  f  GW  �   �Y     2Z  �   3[  �   �[  ~   �\  �   <]     (^  +   F^     r^  &   �^     �^     �^     �^     �^  Q  �^  �   ?a  �   0b  q   c  �   �c  ^   od  d   �d    3e  8   Lf  Q   �f  *   �f  T   g  _   Wg  K   �g  �  h  �  �i  ]   :k  �   �k  �  ?l  �   &n  F   o     Zo     uo     �o  #   �o     �o  n   �o    Jp  �  aq  6   s     Rs     es     ts  �   �s     t  w   -t  s   �t  k   u  �   �u  �   v   **Coisa (Thing):** Diz respeito a qualquer objeto, pessoa ou lugar no mundo real. São representadas como coisas virtuais e, em sua respresentação, possuem um ID de entidade, um tipo e diversos atributos. Sensores podem ser modelados como coisas virtuais, porém, coisas do mundo real, sejam essas concretas ou abstratas, (como quartos, pessoas, grupo, etc.), também podem ser modelados como coisas virtuais. Dados a nível de coisas consistem de descrições das coisas e seus atributos, podendo constar também informações sobre como os dados foram obtidos através de meta  dados. **Dispositivo (Device):** Também conhecido como nó-fim IoT (IoT end-node), diz respeito a uma entidade de hardware, componente ou sistema. Ele é respnsável por medir ou influenciar as propriedades de uma coisa/grupo de coisas (ou ambas, concorrentemente). Sensores e atuadores são exemplos de dispositivos. **Entidade de Contexto NGSI (NGSI Context-Entity):** IoT End-Nodes, Recursos IoT e "Coisas" são representados como Entidades de Contexto NGSI no GE Context Broker do capítulo de dados, logo desenvolvedores precisam aprender apenas a mesma API dessa GE, utilizada para informações de contexto, para também gerenciar informações de aplicações IoT. As informações de medições de sensores pode ser obtida através da leitura de atributos dessas entidades, enquanto o acionamento de comandos em atuadores pode ser feita a partir da atualização em atributos específicos que representam comandos nessas. **Nó-Fim IoT (IoT End-Node):** O termo é usado na documentação para dispositivos físicos complexos com diversos sensores e atuadores, como, por exemplo, um sistema complexo baseado em Arduino. Dispositivos podem usar protocolos de comunicação padronizados ou proprietários, que podem ser enviados nativamente para os GEs de Backend ou traduzidos em outro protocolo padronizado ou proprietário nos Gateways IoT, como a conversão desses protocolos específicos para OMA NGSI que pode ser realizada em GEs FIWARE, por exemplo. Um Arduino ou Raspberry Pi são exemplos de IoT End-Nodes. **Recurso IoT (IoT Resource):** Refere-se a um elemento computacional que provê acesso a dispositivos sensores/atuadores. Um modelo de informação para a descrição de recursos IoT pode incluir informações de contexto, como, por exemplo, localização, precisão, informação de status, etc. Dados a nível de recursos IoT consistem não apenas no dado medido, mas também informação de contexto, como tipo de dado, um instante de tempo, precisão da medição e o sensor a partir do qual a medição foi realizada, etc. Recursos IoT podem ser endereçados usando um esquema de endereçamento uniforme e são geralmente hospedados no dispositivo mas também apresentam uma representação lógica no backend. **Service e Service-Path:** São utilizados para definir o escopo utilizado para a execução de requisições e operações, fazendo com que as operações necessárias sejam realizadas sobre dispositivos e entidades com determinados IDs únicos dentro de um escopo específico, localizados juntamente com os valores do Service e Service-Path definidos no momento do registro e envio de medições a dispositivos. A plataforma `FIWARE <https://www.fiware.org>`__ apresenta um ambiente baseado na plataforma de computação em nuvem `OpenStack <https://www.openstack.org>`__ com algumas modificações bem como com a adição de outros componentes. Ela apresenta um conjunto de APIs padronizadas que, entre outras coisas, torna mais fácil realizar a comunicação com a Internet das Coisas (IoT) e manipulação de informações de contexto. Ela facilita  análises sobre grandes volumes de dados e fornecimento de médias em tempo real, trazendo facilidades para manipulação de informações de contexto, análise de eventos em tempo real, coleta de informações a partir de sensores e ação sobre atuadores, controle de acesso, entre tantas outras funcionalidades. Ao fazer a criação do Service, é criado um banco de dados com o mesmo nome utilizado no momento do cadastro, porém, todo em letras minúsculas. Para cada Entidade registrada é também criada, no banco de dados do seu respectivo serviço, uma tabela no formato "SERVICE_PATH" + "_" + "ID_ENTIDADE" + "_" + "TIPO_ENTIDADE". Após a configuração do config.ini, o próximo passo  é a criação do Service e do Service Path, utilizando a biblioteca fiotclient instalada anteriormente. :: Após a criação do diretório, é criado um ambiente virtual Python :: Após a criação do serviço, haverá uma mensagem de confirmação, junto com uma string, que deve ser guardada em conjunto com o nome do Service e do seu respectivo Service Path para serem usados quando houver o registro de um dispositivo novo. A mensagem de confirmação é mostrada dessa forma: :: Arduino Autores Autores: Com isso o próximo passo é a configuração da entidade que estará se relacionando com o(s) dispositivo(s) da aplicação. Com isso, é possivel enviar os dados coletados pelos dispositivos para um banco de dados, podendo ser um banco no MySQL, MongoDB, etc. Com o ambiente virtual já criado, é feita a instalação do iPython :: Conceituação Teórica Conectando a entidade com o Cygnus Configurando armazenamento (registrando bancos no Orion) Configurar arquivo de configuração (config.ini) Configuração do ambiente virtual Consulta ao Orion Consulta ao banco de dados Criação da entidade Criação do service e do Service Path Depois de feita todas as atribuições, o próximo passo é registrar o dispositivo, no qual é definido por um arquivo no formato JSON, em que alguns exemplos de dispositivos podem ser encontrados neste `repositório <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/tree/master/examples/devices>`__. É recomendado que os arquivos dos disposítivos estejam salvos no mesmo diretório de onde estará rodando a aplicação. E para testar se a instalção foi feita corretamente, fazemos o comando de import do Python :: E por fim, para enviar e armazenar o histórico de dados, utilizamos o seguinte comando: :: ELK Em Breve! Em breve! Em relação a aplicações IoT, a plataforma fornece GEs que permitem que "coisas" se tornem recursos de contexto disponíveis, pesquisáveis, acessíveis e utilizáveis, possibilitando a interação de Apps FIWARE com objetos do mundo real. As "coisas" representam qualquer objeto físico, organismo vivo, pessoa ou conceito de interesse a partir da perspectiva de uma aplicação e seus parâmetros são totalmente ou parcialmente atrelados a sensores, atuadores (ou uma combinação desses). A plataforma ajuda a abstrair a complexidade e alta fragmentação de tecnologias IoT e de cenários de implantação. Em seguida, selecionado o banco de dados do Service, para checar todos os dados registrados em uma entidade é utilizado o comando: Entender alguns conceitos é fundamental para a utilização das APIs FIWARE e, consequentemente, ferramentas que façam uso dessas. Logo, abaixo serão definidos alguns conceitos que facilitam a compreensão do que será apresentado durante esse tutorial. Esse comando executará todos os componentes necessários para a execução do tutorial e, caso nenhuma mensagem de erro tenha sido exibida, deverá estar executando corretamente. Esses conjuntos de funcionalidades são agrupados na plataforma em forma de capítulos, sendo cada um deles composto por um conjunto de GEs (Generic Enablers), nomenclatura dada a componentes dentro da plataforma. Feito isso, agora é feita a atribuição da entidade ao SERVICE e ao SERVICE PATH desejado, utilizando o seguinte comando: :: Inicialmente é necessário realizar a instalação do Docker em sua máquina, caso já não o tenha instalado. Os passos para a instalação em seu sistema operacional pode ser acessado no `link <https://www.docker.com/get-docker>`__. Instalando o back-end: Docker Instalando o front-end : FIoT-Client-Python Instalando o front-end: GUI Web Instalação da biblioteca FIoT-Client Instalação do ambiente Introdução MongoDB Mysql Nela é possível identificar componentes responsáveis pela comunicação com dispositivos (IDAS), armazenamento e manipulação de informações de contexto (Orion Context Broker), comunicação com bases de dados para armazenamento de medições (Cygnus) e as próprias bases de dados utilizadas para realizar essa persistência, tendo sido escolhidos para a execução do tutorial um banco de dados *MySQL* e um *MongoDB*, além do componente FIWARE responsável pelo armazenamento de dados históricos, possibilitando o armazenamento e consulta de dados históricos agregados (STH Comet). Neste exemplo, foi utilizado um sensor de temperatura e umidade DHT21 AM2301, no qual o arquivo se encontra neste `link <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/examples/arduino/FiwareDHT/FiwareDHT.ino>`__. Neste exemplo, foi utilizado um sensor de temperatura e umidade DHT22 AM2302, no qual o arquivo se encontra neste `link <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/examples/example_DHT2302.py>`__. O ambiente é formado por dois componentes: o back-end utilizando Docker, e o front-end utilizando o FIoT-Client. OBS: Caso já exista um ambiente configurado e disponível que apresenta os componentes utilizados pelo tutorial e apresentados na imagem acima, é possível pular os passos seguintes para configuração do ambiente em sua máquina. Onde 'NOME_DO_BANCO_DE_DADOS' deve ser substituído pelo nome do banco criado para o serviço. Onde 'TABELA_DA_ENTIDADE' deve ser substituído pelo nome da tabela criada para a entidade desejada. Para a criação da entidade, devemos primeiro importar da biblioteca fiotclient os métodos relacionados ao módulo de acesso à API da entidade, após isso devemos configurar os componentes da entidade usando o arquivo config.ini, e esse passo é feito através dos comandos: :: Para a instalação da biblioteca, é usado o comando :: Para acessar o banco que está sendo utilizado no Service é utilizado o comando: Para ativá-lo, usamos o comando source :: Para checarmos as informações referentes a essa entidade, utilizamos o comando: :: Para começar, deve ser criado um diretório onde ficará o ambiente instalado, e acessá-lo :: Para conectarmos a entidade com o Cygnus, uitlizamos o seguinte comando: :: Para criar o ambiente composto por todos esses componentes foi utilizada a ferramenta `Docker <https://www.docker.com>`__, que permite que, a partir de imagens disponibilizadas dos componentes FIWARE selecionados, seja possível definir parâmetros de configuração bem como a forma como ocorrerá a comunicação entre esses componentes e o modo que esses estarão acessíveis para uso por aplicações. Para iniciar o registro do dispositivo, primeiro devemos criar um arquivo de configuração, porém para facilitar o andamento do tutorial, há um arquivo pré-programado de configuração neste `repositório <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/config.ini>`__, no qual a partir dele o usuário pode alterar os valores dos endereços dos componentes dos quais ele irá utilizar. Para listagem dos dispositivos que estão registrados neste SERVICE, utilizamos o comando: :: Para o registro de um novo dispositivo, primeiros devemos selecionar em qual Service e em qual Service Path ele irá ficar, no qual é feito utilizando os comando: :: Para preparar o ambiente para a execução do tutorial, precisamos primeiro rodar os GEs que serão necessários para a criação de aplicações IoT utilizando o FIWARE. Para isso, foi planejada a arquitetura apresentada neste `link <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/extras/arquitetura.jpg>`__, composta pelos principais componentes necessários para criação de aplicações que usem recursos de manipulação de contexto e IoT na plataforma. Para testar se o ambiente foi configurado e está sendo executado corretamente, abra o seu navegador e acesse o endereço localhost:1026/version e deverá ser retornado um *JSON* apresentando a versão do componente Orion em execução. Por fim, para registrar o dispositivo, é usado o seguinte comando: :: Programando um dispositivo Raspberry Pi Registrando o dispositivo Registrando o dispositivo no Fiware Registrando um dispositivo Sendo os atributos o id da entidade na qual se deseja conectar com o Cygnus, e os atributos dos dispositivos . Também é necessário instalar a ferramenta docker-compose, que possibilitará que o ambiente composto por todos os componentes selecionados possa ser facilmente executado. Os passos para a instalação podem ser acessados no `link <https://docs.docker.com/compose/install>`__. Tendo instalado corretamente o Docker e o docker-compose, você está pronto para rodar o ambiente. Para isso, você deverá acessar o diretório no qual o repositório de tutorial foi clonado, no qual existe um arquivo chamado `docker-compose.yml <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/deploy/full/docker-compose.yml>`__, e, a partir da linha de comando do seu sistema operacional, executar o comando: :: Tutorial de instalação e utilização do FIoT-Client Usando FIoT-Client Usando Web Gui Usando o WEB GUI Usando os valores guardados anteriormente. Com isso, o passo seguinte se dá por atribuir a API_KEY para o dispositivo, usando o comando: Visualizando os dados gerados `Carlos Eduardo da Silva (Orientador)  <https://projetos.imd.ufrn.br/kaduardo>`__ -> `Contato <kaduardo@imd.ufrn.br>`__ `Lucas Cristiano Calixto Dantas <https://github.com/lucascriistiano>`__ -> `Contato <lucascristiano27@gmail.com>`__ `Lucas Ramon Bandeira da Silva <https://github.com/lucasramon>`__ -> `Contato <lucas.ramon.jc@gmail.com>`__ obs: o caminho do serviço deve ser precedido de uma barra '/' e não pode conter certos caracteres especiais como por exemplo o underscore ('_'). tendo como argumentos o diretório em que está salvo o arquivo do dispositivo, o id do dispositivo, e o id da entidade na qual o dispositivo esta se relacionando, respectivamente. Todos estes valores estão contidos no arquivo JSON do dispositivo,. Project-Id-Version: fiotclient 
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2018-01-08 21:00-0200
PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE
Last-Translator: FULL NAME <EMAIL@ADDRESS>
Language: en
Language-Team: en <LL@li.org>
Plural-Forms: nplurals=2; plural=(n != 1)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.5.1
 **Coisa (Thing):** Diz respeito a qualquer objeto, pessoa ou lugar no mundo real. São representadas como coisas virtuais e, em sua respresentação, possuem um ID de entidade, um tipo e diversos atributos. Sensores podem ser modelados como coisas virtuais, porém, coisas do mundo real, sejam essas concretas ou abstratas, (como quartos, pessoas, grupo, etc.), também podem ser modelados como coisas virtuais. Dados a nível de coisas consistem de descrições das coisas e seus atributos, podendo constar também informações sobre como os dados foram obtidos através de meta  dados. **Dispositivo (Device):** Também conhecido como nó-fim IoT (IoT end-node), diz respeito a uma entidade de hardware, componente ou sistema. Ele é respnsável por medir ou influenciar as propriedades de uma coisa/grupo de coisas (ou ambas, concorrentemente). Sensores e atuadores são exemplos de dispositivos. **Entidade de Contexto NGSI (NGSI Context-Entity):** IoT End-Nodes, Recursos IoT e "Coisas" são representados como Entidades de Contexto NGSI no GE Context Broker do capítulo de dados, logo desenvolvedores precisam aprender apenas a mesma API dessa GE, utilizada para informações de contexto, para também gerenciar informações de aplicações IoT. As informações de medições de sensores pode ser obtida através da leitura de atributos dessas entidades, enquanto o acionamento de comandos em atuadores pode ser feita a partir da atualização em atributos específicos que representam comandos nessas. **Nó-Fim IoT (IoT End-Node):** O termo é usado na documentação para dispositivos físicos complexos com diversos sensores e atuadores, como, por exemplo, um sistema complexo baseado em Arduino. Dispositivos podem usar protocolos de comunicação padronizados ou proprietários, que podem ser enviados nativamente para os GEs de Backend ou traduzidos em outro protocolo padronizado ou proprietário nos Gateways IoT, como a conversão desses protocolos específicos para OMA NGSI que pode ser realizada em GEs FIWARE, por exemplo. Um Arduino ou Raspberry Pi são exemplos de IoT End-Nodes. **Recurso IoT (IoT Resource):** Refere-se a um elemento computacional que provê acesso a dispositivos sensores/atuadores. Um modelo de informação para a descrição de recursos IoT pode incluir informações de contexto, como, por exemplo, localização, precisão, informação de status, etc. Dados a nível de recursos IoT consistem não apenas no dado medido, mas também informação de contexto, como tipo de dado, um instante de tempo, precisão da medição e o sensor a partir do qual a medição foi realizada, etc. Recursos IoT podem ser endereçados usando um esquema de endereçamento uniforme e são geralmente hospedados no dispositivo mas também apresentam uma representação lógica no backend. **Service e Service-Path:** São utilizados para definir o escopo utilizado para a execução de requisições e operações, fazendo com que as operações necessárias sejam realizadas sobre dispositivos e entidades com determinados IDs únicos dentro de um escopo específico, localizados juntamente com os valores do Service e Service-Path definidos no momento do registro e envio de medições a dispositivos. A plataforma `FIWARE <https://www.fiware.org>`__ apresenta um ambiente baseado na plataforma de computação em nuvem `OpenStack <https://www.openstack.org>`__ com algumas modificações bem como com a adição de outros componentes. Ela apresenta um conjunto de APIs padronizadas que, entre outras coisas, torna mais fácil realizar a comunicação com a Internet das Coisas (IoT) e manipulação de informações de contexto. Ela facilita  análises sobre grandes volumes de dados e fornecimento de médias em tempo real, trazendo facilidades para manipulação de informações de contexto, análise de eventos em tempo real, coleta de informações a partir de sensores e ação sobre atuadores, controle de acesso, entre tantas outras funcionalidades. Ao fazer a criação do Service, é criado um banco de dados com o mesmo nome utilizado no momento do cadastro, porém, todo em letras minúsculas. Para cada Entidade registrada é também criada, no banco de dados do seu respectivo serviço, uma tabela no formato "SERVICE_PATH" + "_" + "ID_ENTIDADE" + "_" + "TIPO_ENTIDADE". Após a configuração do config.ini, o próximo passo  é a criação do Service e do Service Path, utilizando a biblioteca fiotclient instalada anteriormente. :: Após a criação do diretório, é criado um ambiente virtual Python :: Após a criação do serviço, haverá uma mensagem de confirmação, junto com uma string, que deve ser guardada em conjunto com o nome do Service e do seu respectivo Service Path para serem usados quando houver o registro de um dispositivo novo. A mensagem de confirmação é mostrada dessa forma: :: Arduino Autores Autores: Com isso o próximo passo é a configuração da entidade que estará se relacionando com o(s) dispositivo(s) da aplicação. Com isso, é possivel enviar os dados coletados pelos dispositivos para um banco de dados, podendo ser um banco no MySQL, MongoDB, etc. Com o ambiente virtual já criado, é feita a instalação do iPython :: Conceituação Teórica Conectando a entidade com o Cygnus Configurando armazenamento (registrando bancos no Orion) Configurar arquivo de configuração (config.ini) Configuração do ambiente virtual Consulta ao Orion Consulta ao banco de dados Criação da entidade Criação do service e do Service Path Depois de feita todas as atribuições, o próximo passo é registrar o dispositivo, no qual é definido por um arquivo no formato JSON, em que alguns exemplos de dispositivos podem ser encontrados neste `repositório <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/tree/master/examples/devices>`__. É recomendado que os arquivos dos disposítivos estejam salvos no mesmo diretório de onde estará rodando a aplicação. E para testar se a instalção foi feita corretamente, fazemos o comando de import do Python :: E por fim, para enviar e armazenar o histórico de dados, utilizamos o seguinte comando: :: ELK Em Breve! Em breve! Em relação a aplicações IoT, a plataforma fornece GEs que permitem que "coisas" se tornem recursos de contexto disponíveis, pesquisáveis, acessíveis e utilizáveis, possibilitando a interação de Apps FIWARE com objetos do mundo real. As "coisas" representam qualquer objeto físico, organismo vivo, pessoa ou conceito de interesse a partir da perspectiva de uma aplicação e seus parâmetros são totalmente ou parcialmente atrelados a sensores, atuadores (ou uma combinação desses). A plataforma ajuda a abstrair a complexidade e alta fragmentação de tecnologias IoT e de cenários de implantação. Em seguida, selecionado o banco de dados do Service, para checar todos os dados registrados em uma entidade é utilizado o comando: Entender alguns conceitos é fundamental para a utilização das APIs FIWARE e, consequentemente, ferramentas que façam uso dessas. Logo, abaixo serão definidos alguns conceitos que facilitam a compreensão do que será apresentado durante esse tutorial. Esse comando executará todos os componentes necessários para a execução do tutorial e, caso nenhuma mensagem de erro tenha sido exibida, deverá estar executando corretamente. Esses conjuntos de funcionalidades são agrupados na plataforma em forma de capítulos, sendo cada um deles composto por um conjunto de GEs (Generic Enablers), nomenclatura dada a componentes dentro da plataforma. Feito isso, agora é feita a atribuição da entidade ao SERVICE e ao SERVICE PATH desejado, utilizando o seguinte comando: :: Inicialmente é necessário realizar a instalação do Docker em sua máquina, caso já não o tenha instalado. Os passos para a instalação em seu sistema operacional pode ser acessado no `link <https://www.docker.com/get-docker>`__. Instalando o back-end: Docker Instalando o front-end : FIoT-Client-Python Instalando o front-end: GUI Web Instalação da biblioteca FIoT-Client Instalação do ambiente Introdução MongoDB Mysql Nela é possível identificar componentes responsáveis pela comunicação com dispositivos (IDAS), armazenamento e manipulação de informações de contexto (Orion Context Broker), comunicação com bases de dados para armazenamento de medições (Cygnus) e as próprias bases de dados utilizadas para realizar essa persistência, tendo sido escolhidos para a execução do tutorial um banco de dados *MySQL* e um *MongoDB*, além do componente FIWARE responsável pelo armazenamento de dados históricos, possibilitando o armazenamento e consulta de dados históricos agregados (STH Comet). Neste exemplo, foi utilizado um sensor de temperatura e umidade DHT21 AM2301, no qual o arquivo se encontra neste `link <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/examples/arduino/FiwareDHT/FiwareDHT.ino>`__. Neste exemplo, foi utilizado um sensor de temperatura e umidade DHT22 AM2302, no qual o arquivo se encontra neste `link <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/examples/example_DHT2302.py>`__. O ambiente é formado por dois componentes: o back-end utilizando Docker, e o front-end utilizando o FIoT-Client. OBS: Caso já exista um ambiente configurado e disponível que apresenta os componentes utilizados pelo tutorial e apresentados na imagem acima, é possível pular os passos seguintes para configuração do ambiente em sua máquina. Onde 'NOME_DO_BANCO_DE_DADOS' deve ser substituído pelo nome do banco criado para o serviço. Onde 'TABELA_DA_ENTIDADE' deve ser substituído pelo nome da tabela criada para a entidade desejada. Para a criação da entidade, devemos primeiro importar da biblioteca fiotclient os métodos relacionados ao módulo de acesso à API da entidade, após isso devemos configurar os componentes da entidade usando o arquivo config.ini, e esse passo é feito através dos comandos: :: Para a instalação da biblioteca, é usado o comando :: Para acessar o banco que está sendo utilizado no Service é utilizado o comando: Para ativá-lo, usamos o comando source :: Para checarmos as informações referentes a essa entidade, utilizamos o comando: :: Para começar, deve ser criado um diretório onde ficará o ambiente instalado, e acessá-lo :: Para conectarmos a entidade com o Cygnus, uitlizamos o seguinte comando: :: Para criar o ambiente composto por todos esses componentes foi utilizada a ferramenta `Docker <https://www.docker.com>`__, que permite que, a partir de imagens disponibilizadas dos componentes FIWARE selecionados, seja possível definir parâmetros de configuração bem como a forma como ocorrerá a comunicação entre esses componentes e o modo que esses estarão acessíveis para uso por aplicações. Para iniciar o registro do dispositivo, primeiro devemos criar um arquivo de configuração, porém para facilitar o andamento do tutorial, há um arquivo pré-programado de configuração neste `repositório <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/config.ini>`__, no qual a partir dele o usuário pode alterar os valores dos endereços dos componentes dos quais ele irá utilizar. Para listagem dos dispositivos que estão registrados neste SERVICE, utilizamos o comando: :: Para o registro de um novo dispositivo, primeiros devemos selecionar em qual Service e em qual Service Path ele irá ficar, no qual é feito utilizando os comando: :: Para preparar o ambiente para a execução do tutorial, precisamos primeiro rodar os GEs que serão necessários para a criação de aplicações IoT utilizando o FIWARE. Para isso, foi planejada a arquitetura apresentada neste `link <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/extras/arquitetura.jpg>`__, composta pelos principais componentes necessários para criação de aplicações que usem recursos de manipulação de contexto e IoT na plataforma. Para testar se o ambiente foi configurado e está sendo executado corretamente, abra o seu navegador e acesse o endereço localhost:1026/version e deverá ser retornado um *JSON* apresentando a versão do componente Orion em execução. Por fim, para registrar o dispositivo, é usado o seguinte comando: :: Programando um dispositivo Raspberry Pi Registrando o dispositivo Registrando o dispositivo no Fiware Registrando um dispositivo Sendo os atributos o id da entidade na qual se deseja conectar com o Cygnus, e os atributos dos dispositivos . Também é necessário instalar a ferramenta docker-compose, que possibilitará que o ambiente composto por todos os componentes selecionados possa ser facilmente executado. Os passos para a instalação podem ser acessados no `link <https://docs.docker.com/compose/install>`__. Tendo instalado corretamente o Docker e o docker-compose, você está pronto para rodar o ambiente. Para isso, você deverá acessar o diretório no qual o repositório de tutorial foi clonado, no qual existe um arquivo chamado `docker-compose.yml <https://projetos.imd.ufrn.br/FIoT-Client/fiot-client-tutorial/blob/master/deploy/full/docker-compose.yml>`__, e, a partir da linha de comando do seu sistema operacional, executar o comando: :: Tutorial de instalação e utilização do FIoT-Client Usando FIoT-Client Usando Web Gui Usando o WEB GUI Usando os valores guardados anteriormente. Com isso, o passo seguinte se dá por atribuir a API_KEY para o dispositivo, usando o comando: Visualizando os dados gerados `Carlos Eduardo da Silva (Orientador)  <https://projetos.imd.ufrn.br/kaduardo>`__ -> `Contato <kaduardo@imd.ufrn.br>`__ `Lucas Cristiano Calixto Dantas <https://github.com/lucascriistiano>`__ -> `Contato <lucascristiano27@gmail.com>`__ `Lucas Ramon Bandeira da Silva <https://github.com/lucasramon>`__ -> `Contato <lucas.ramon.jc@gmail.com>`__ obs: o caminho do serviço deve ser precedido de uma barra '/' e não pode conter certos caracteres especiais como por exemplo o underscore ('_'). tendo como argumentos o diretório em que está salvo o arquivo do dispositivo, o id do dispositivo, e o id da entidade na qual o dispositivo esta se relacionando, respectivamente. Todos estes valores estão contidos no arquivo JSON do dispositivo,. 