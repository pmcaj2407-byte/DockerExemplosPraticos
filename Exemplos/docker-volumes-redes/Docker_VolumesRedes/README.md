# Demonstração simples: volumes, redes e variáveis de ambiente com Docker

Este exemplo usa somente dois containers:

- `web`: servidor Nginx, acessível no navegador em http://localhost:8085.
- `client`: container Alpine usado para testar a comunicação interna e consultar uma variável de ambiente.

Os dois serviços estão conectados à rede Bridge `demo_net`. O serviço `web` utiliza o volume nomeado `site_data` para armazenar a página HTML.

## Pré-requisitos

- Docker Desktop instalado e aberto no Windows.
- Conexão com a internet na primeira execução, para baixar as imagens.

Não é necessário criar arquivo `.env`, configurar usuário ou senha, nem instalar PostgreSQL.

## 1. Abrir o terminal na pasta do projeto

No Explorador de Arquivos, abra a pasta que contém o arquivo `compose.yaml`. Clique na barra de endereço, digite `cmd` e pressione Enter.

Confirme que está na pasta correta com:

```cmd
 dir
```

O arquivo `compose.yaml` deve aparecer na listagem.

## 2. Iniciar os containers

```cmd
docker compose up -d
```

Verifique se os dois serviços estão em execução:

```cmd
docker compose ps
```

## 3. Criar um arquivo dentro do volume

Execute o comando abaixo. Ele grava uma página no diretório do Nginx, que está conectado ao volume `site_data`:

```cmd
docker compose exec web sh -c "echo Volume Docker: este arquivo continua existindo apos recriar o container. > /usr/share/nginx/html/index.html"
```

Abra no navegador:

http://localhost:8085

A página deve mostrar a mensagem gravada.

## 4. Demonstrar a comunicação pela rede Bridge

O container `client` acessa o Nginx pelo nome do serviço `web`, sem precisar descobrir seu endereço IP:

```cmd
docker compose exec client wget -qO- http://web
```

O comando deve retornar o conteúdo da página. Isso demonstra a comunicação e a resolução de nomes na rede Bridge definida pelo usuário.

## 5. Demonstrar a variável de ambiente

```cmd
docker compose exec client printenv APP_MODE
```

O resultado esperado é:

```text
demonstracao
```

## 6. Demonstrar a persistência do volume

Remova os containers e a rede, sem remover o volume:

```cmd
docker compose down
```

Inicie os serviços novamente:

```cmd
docker compose up -d
```

Atualize http://localhost:8085. A mensagem criada anteriormente continuará aparecendo, pois o arquivo está armazenado no volume nomeado `site_data`, que sobrevive à remoção dos containers.

**Atenção:** não use `docker compose down -v` antes de concluir a demonstração. A opção `-v` também remove o volume e os dados armazenados nele.

## 7. Limpar o ambiente depois da demonstração (opcional)

Somente depois de terminar, para remover também o volume e os dados:

```cmd
docker compose down -v
```

## Problemas comuns

- **`docker` não é reconhecido:** instale/abra o Docker Desktop e abra um novo terminal.
- **Não foi possível conectar ao Docker Engine:** abra o Docker Desktop e aguarde o Engine ficar em execução.
- **`no configuration file provided`:** o terminal não está na pasta onde está o `compose.yaml`. Entre na pasta correta e tente novamente.
- **A porta 8085 já está em uso:** no `compose.yaml`, troque `"8085:80"` por `"8086:80"`, salve, execute `docker compose up -d` novamente e acesse http://localhost:8086.
