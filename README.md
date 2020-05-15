# Ambiente para desenvolvimento de pacotes Magento 2

Esse repositório contém um kit desenvolvimento com instaladores automaticos e comandos pré-definidos para facilitar o desenvolvimento de pacotes dentro do Magento 2.

Para esse SDK funcionar é necessário que você tenha o [Docker](https://docs.docker.com/docker-for-mac/install/) e [Docker Compose](https://docs.docker.com/compose/install/#install-compose) instalado.


Uma vez que o repositório foi clonado e instalado você terá um ambiente com:

* PHP 7.1
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