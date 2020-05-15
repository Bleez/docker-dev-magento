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

##### :warning: :apple: Configurações para OSX

O docker tem problemas ao ler arquivos no Mac e isso causa lentidão. Para contornar esse problema a gente utiliza NFS nos volumes, porém para que o Mac consiga ler arquivos usando esse modo é necessário rodar o arquivo `nfs.sh`.

Ainda dentro da pasta `/dev` rode os comandos:

```bash
$ sudo chmod +x nfs.sh

$ ./nfs.sh
```

Informe `y` sempre que perguntar e aguarde concluir os ajustes.

**Não continue antes de executar esse passo ou não vai funcionar**

### Iniciando containers

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

> :warning: Não instale o Magento através do navegador. Use o instalador do ambiente.

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

### Comandos para gerenciar ambiente

Os comandos abaixo devem ser executados na rais do ambiente

#### ./start

Inicia os containers que farão o ambiente funcionar.

Exemplo
```bash
$ ./start
```

#### ./stop

Desliga os containers sem destruí-los.

Exemplo
```bash
$ ./stop
```

#### ./kill

Desliga e destrói todos os containers, volumes, networks e imagens usadas. Os arquivos do ambiente e do magento dentro de `/src` **não são excluídos**.

Exemplo
```bash
$ ./kill
```

#### ./logs

Mostra na tela o logs de execução de todos os containers. Ideal para entender se algum container teve problema para iniciar.

Exemplo
```bash
$ ./logs
```

#### ./shell

Entra dentro do container de um determinado serviço.

Exemplo
```bash
$ ./shell php
```

#### git pull

Atualiza ambiente com as últimas modificações.

Exemplo
```bash
$ git pull
```

### Comandos para trabalhar com Magento

Os comando abaixo devem ser executados dentro do container `php` através do comando `./shell php`.

#### install-magento2

Executa instalação do Magento que está instalado na dentro de `/src`.

Exemplo
```bash
$ install-magento2
```

#### redis-flush

Limpa todo o Redis, tanto o cache de arquivos como a sessão.

Exemplo
```bash
$ redis-flush
```