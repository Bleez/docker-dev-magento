# Ambiente para desenvolvimento de pacotes Magento 2

Esse repositório contém um ambiente de desenvolvimento com instaladores automaticos e comandos pré-definidos para facilitar o desenvolvimento de pacotes dentro do Magento 2.

Para esse SDK funcionar é necessário que você tenha o [Docker](https://docs.docker.com/docker-for-mac/install/) e [Docker Compose](https://docs.docker.com/compose/install/#install-compose) instalado.


Uma vez que o repositório foi clonado e instalado você terá um ambiente com:

* PHP 7.2
* Nginx
* Maria DB
* Redis
* NPM
* NVM
* Grunt
* Composer
* XDebug
* PHPMyAdmin
* Mailhog

## Instalação

```bash
$ git clone git@github.com:Bleez/docker-dev-magento.git magento-pacotes-bleez && cd magento-pacotes-bleez
```

Você pode trocar `magento-pacotes-bleez` por qualquer outro nome de sua preferência.

Em seguida instale o ambiente rodando:

```bash
$ ./install
```

Depois que esse processo terminar você precisa iniciar os containers para começar a usar o ambiente com o comando `./start`.

Exemplo:
```bash
$ ./start
```

Este comando instalará todas as imagens que o Docker precisa para fazer o ambiente funcionar e iniciará os mesmos.

> O Comando `./install` também irá clonar o [Magento Bleez](https://github.com/Bleez/magento-dev-pacotes) próprio para desenvolvimento de pacotes. Ele contém comandos especiais para ajudar no desenvolvimento e testes dos pacotes. Consulte a página do repositório para saber mais.

Se você quiser parar os containers execute o comando `./stop`.

Exemplo:
```bash
$ ./stop
```

### Instalando o Magento

Para instalar o Magento precisaremos entrar dentro do container e executar a instalação lá de dentro. Para isso, uma vez que você iniciou os containers com o comando `./start`, digite:

```bash
$ ./shell php
```

Uma vez dentro do container rode o comando `composer install` para instalar as dependências.

```bash
$ composer install
```

Depois execute `install-magento2` para fazer a instalação do Magento.

```bash
$ install-magento2
```

Uma vez instalado a loja estará disponível no endereço `http://127.0.0.1/`. Para acessar a administração use as credenciais:

* **Url:** http://127.0.0.1/admin
* **Login:** admin
* **Senha:** admin1234

## Entrando nos containers

Pode acontecer casos que você precise entrar dentro de um dos containers. Caso você tenha essa necessidade você pode fazer isso usando o comando `./shell <servico>`.

Por exemplo, caso você queira executar no container que roda o PHP, execute:

```bash
$ ./shell php
```

Estes são os serviços disponíveis nesse comando:

* php
* nginx
* db
* phpmyadmin

## Lista de comandos disponíveis

Abaixo a lista de todos os comandos disponíveis no ambiente.

### ./start

Inicia os containers que farão o ambiente funcionar. Deve ser executado na raiz do ambiente.

Exemplo
```bash
$ ./start
```

### ./stop

Desliga os containers sem destruí-los. Deve ser executado na raiz do ambiente.

Exemplo
```bash
$ ./stop
```

### ./kill

Desliga e destrói todos os containers, volumes, networks e imagens usadas. Os arquivos do ambiente e do magento dentro de `/src` **não são excluídos**. Deve ser executado na raiz do ambiente.

Exemplo
```bash
$ ./kill
```

### ./logs

Mostra na tela o logs de execução de todos os containers. Ideal para entender se algum container teve problema para iniciar. Deve ser executado na raiz do ambiente.

Exemplo
```bash
$ ./logs
```

### ./shell

Entra dentro do container de um determinado serviço. Deve ser executado na raiz do ambiente.

Exemplo
```bash
$ ./shell php
```

### git pull

Atualiza ambiente com as últimas modificações. Deve ser executado na raiz do ambiente.

Exemplo
```bash
$ git pull
```