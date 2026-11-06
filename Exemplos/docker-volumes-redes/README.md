# Demonstração: volumes, redes e dados com Docker Compose

Este exemplo sobe dois containers:

- **db**: PostgreSQL 17, com os dados persistidos em um volume nomeado (`postgres_data`).
- **adminer**: interface web para consultar o banco. Ele encontra o PostgreSQL pelo nome do serviço `db`, dentro de uma rede bridge criada para a demonstração.

O objetivo é demonstrar que os dados não ficam presos ao ciclo de vida do container e que serviços em uma mesma rede Docker conseguem se comunicar.

## Pré-requisitos

- Docker instalado e em execução.
- Docker Compose v2 (`docker compose`).

## Como executar

1. Copie `.env.example` para `.env`.
2. Abra `.env` e troque `POSTGRES_PASSWORD` por uma senha de demonstração.
3. Na pasta deste exemplo, execute:

   ```bash
   docker compose up -d
   ```

4. Acesse <http://localhost:8080> e entre com:

   - Sistema: **PostgreSQL**
   - Servidor: **db**
   - Usuário: valor de `POSTGRES_USER` no `.env` (padrão: `demo`)
   - Senha: valor de `POSTGRES_PASSWORD` no `.env`
   - Base de dados: valor de `POSTGRES_DB` no `.env` (padrão: `demo`)

5. Execute esta consulta no Adminer:

   ```sql
   SELECT * FROM mensagens;
   ```

6. Insira um novo registro:

   ```sql
   INSERT INTO mensagens (texto) VALUES ('Meu teste de persistência');
   ```

## Como comprovar a persistência

1. Remova os containers sem remover os volumes:

   ```bash
   docker compose down
   ```

2. Suba novamente:

   ```bash
   docker compose up -d
   ```

3. Volte ao Adminer e execute `SELECT * FROM mensagens;`. O registro inserido anteriormente continuará lá.

Isso acontece porque `postgres_data` é um **volume nomeado**, gerenciado pelo Docker e independente do container.

## Comandos úteis

```bash
# Ver os serviços em execução
docker compose ps

# Ver os logs do PostgreSQL
docker compose logs db

# Listar volumes Docker
docker volume ls

# Ver detalhes do volume criado
docker volume inspect <nome-do-volume>
```

O nome real do volume normalmente recebe o prefixo do projeto Compose. Use `docker volume ls` para identificá-lo.

## Limpeza

Para remover também o volume e apagar os dados persistidos, execute:

```bash
docker compose down -v
```

**Atenção:** `down -v` é destrutivo para esta demonstração: ele remove o volume nomeado e os dados do banco.

## O que observar na implementação

- `volumes: postgres_data:/var/lib/postgresql/data`: conecta o volume nomeado ao diretório de dados do PostgreSQL.
- `networks: demo_net` com `driver: bridge`: coloca os dois serviços em uma rede isolada do projeto.
- `ADMINER_DEFAULT_SERVER: db`: o Adminer usa o DNS interno do Docker para encontrar o serviço PostgreSQL pelo nome `db`; não precisa usar o IP do container.
- `ports` do serviço `adminer`: publica a interface web somente no loopback da máquina (`127.0.0.1:8080`). O PostgreSQL não publica uma porta para o host: fica acessível apenas aos serviços conectados à rede Docker, como o Adminer.
- `.env`: externaliza configurações. O arquivo `.env` real não deve ser enviado ao Git; apenas `.env.example` deve ser versionado.
- O script em `init/` cria a tabela e o registro inicial quando o banco é inicializado pela primeira vez. Scripts de inicialização não são executados novamente se o volume já contém um banco inicializado.

## Observação de segurança

Este projeto é didático. Para produção, não use a senha de exemplo nem trate um arquivo `.env` como um cofre de segredos. Use um mecanismo apropriado de secrets e controle de acesso.
