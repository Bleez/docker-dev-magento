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

### Habilitando o NFS

O Docker pode apresentar lentidões, principalmente no Mac. Isso acontece por conta da forma como o container sincroniza arquivos com host. Para aliviar essa lentidão a gente utiliza NFS nos volumes.

**:warning: Esse passo é importantíssimo, não pule ele ou nada irá funcionar.**

##### Configurações para OSX :apple:

No Mac você só precisa rodar o arquivo `nfs.sh` disponível na pasta `/image`.

```bash
$ cd image

$ sudo chmod +x nfs.sh

$ ./nfs.sh
```

Informe `y` sempre que perguntar e aguarde concluir os ajustes.

##### Configurações para Linux :penguin:

No Linux tem um processo um pouco diferente para instalar o NFS. Siga os passos abaixo.

```bash
sudo apt install nfs-kernel-server -y 

sudo groupadd docker && sudo usermod -aG docker $USER 
```

O comando abaixo compartilha a pasta `html` na pasta do seu usuário para ser usado pelos volumes do Docker. Se sua pasta for outra você deve mudar nesse comando.

```bash
echo "$HOME/html *(rw,sync,no_subtree_check,no_root_squash)" | sudo tee -a /etc/exports

sudo exportfs -a && sudo systemctl restart nfs-kernel-server
```

### Iniciando containers

Depois que esse processo terminar você precisa iniciar os containers para começar a usar o ambiente com o comando `./start`.

Exemplo:
```bash
$ ./start
```

> Por padrão o ambiente usará as portas 80, 8080 e 3306. Se quiser mudar as portas que os containers usa edite arquivo `.env` localizado na raiz.

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

Nesse momento o composer pedirá para você informar suas chaves de autenticação. Você pode conseguí-las seguinto [estas instruções](https://devdocs.magento.com/guides/v2.3/install-gde/prereq/connect-auth.html)

Depois execute `install-magento` para fazer a instalação do Magento.

```bash
$ install-magento
```

> Dica: Se você precisar reinstalar o Magento do zero basta você apagar todas as tabelas do banco de dados e executar novamente `install-magento`

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

#### ./update

Atualiza ambiente com as últimas modificações.

Exemplo
```bash
$ ./update
```

### Comandos para trabalhar com Magento

Os comando abaixo devem ser executados dentro do container `php` através do comando `./shell php`.

#### install-magento

Executa instalação do Magento que está instalado na dentro de `/src`.

Exemplo
```bash
$ install-magento
```

#### redis-flush

Limpa todo o Redis, tanto o cache de arquivos como a sessão.

Exemplo
```bash
$ redis-flush
```

#### xdebug

Habilita ou desabilita o uso do Xdebug ao rodar o PHP via linha de comando.

Exemplo
```bash
$ xdebug
```

#### m2_upgrade

Limpa a pasta `/var` e roda o `setup:upgrade`

Exemplo
```bash
$ m2_upgrade
```

#### m2_clear

Limpa a pasta `/var` e apaga todos os arquivos compilados pelo Magento (`/generated` e `/pub/static`).

Exemplo
```bash
$ m2_clear
```

#### m2_deploy

Limpa tudo rodando `m2_clear` e em seguida roda `setup:static-content:deploy pt_BR -f`.

Exemplo
```bash
$ m2_deploy
```

#### m2_reindex

Reindexa a loja inteira

Exemplo
```bash
$ m2_reindex
```

#### m2_collect_phrases

Executa `i18n:collect-phrases` dentro da pasta do tema do cliente (`/app/project/tema-do-cliente`) especificado por parâmetro.

Exemplo
```bash
$ m2_collect_phrases tema-do-cliente
```

#### disable_fucking_modules

Desabilita modulos que não são necessários para desenvolvimento. Isso pode deixar o processamente e a velocidade do Magento mais leve.

Exemplo
```bash
$ disable_fucking_modules
```

