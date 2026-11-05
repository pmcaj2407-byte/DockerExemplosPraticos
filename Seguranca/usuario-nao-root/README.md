# Execução de container com usuário não-root

# OBJETIVO

Demonstrar como configurar uma imagem Docker para executar processos utilizando um usuário sem privilégios administrativos, reduzindo os riscos associados à execução de aplicações como root.

# ARQUIVOS

usuario-nao-root/
- `Dockerfile`: contém as instruções para construir a imagem e configurar o usuário não-root.

# FUNCIONAMENTO

O Dockerfile utiliza as seguintes instruções:

```dockerfile
FROM ubuntu:24.04
RUN useradd -m aplicativo
USER aplicativo
CMD ["whoami"]
```

- `FROM`: define a imagem base utilizada, neste caso, Ubuntu 24.04.
- `RUN`: executa um comando durante a construção da imagem. Aqui, cria um usuário chamado `aplicativo`.
- `USER`: define o usuário que executará os próximos processos do container.
- `CMD`: define o comando executado quando o container for iniciado. Neste exemplo, `whoami` exibe o nome do usuário em execução.

# COMO EXECUTAR

Construir a imagem:

```bash
docker build -t exemplo-non-root .
```

Executar o container:

```bash
docker run --rm exemplo-non-root
```

# RESULTADO ESPERADO

aplicativo
-------------------------------------
O resultado demonstra que o processo foi executado utilizando o usuário `aplicativo`, em vez do usuário root.