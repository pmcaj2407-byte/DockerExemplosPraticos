# Limitação de recursos com Docker

# OBJETIVO

Demonstrar como limitar o consumo de memória e CPU de um container, evitando que uma aplicação utilize recursos excessivos do servidor.

# ARQUIVOS

Este exemplo não utiliza arquivos próprios. O comando para criar o container e definir seus limites é executado diretamente no terminal:

```bash
docker run -d --name exemplo-limites --memory=512m --cpus=1 ubuntu:24.04 sleep infinity
```

# FUNCIONAMENTO

O Docker utiliza Cgroups (Control Groups) para controlar e limitar os recursos disponíveis para os containers.

No comando apresentado:

- `docker run`: cria e inicia um container.
- `-d`: executa o container em segundo plano.
- `--name`: define o nome do container.
- `--memory=512m`: estabelece um limite máximo de 512 MB de memória.
- `--cpus=1`: limita o uso de CPU ao equivalente a um processador.
- `ubuntu:24.04`: define a imagem utilizada.
- `sleep infinity`: mantém o container em execução indefinidamente.

# COMO EXECUTAR

Criar e executar o container:

```bash
docker run -d --name exemplo-limites --memory=512m --cpus=1 ubuntu:24.04 sleep infinity
```

Remover o container após o teste:

```bash
docker rm -f exemplo-limites
```

# RESULTADO ESPERADO

O container será iniciado em segundo plano, com limite máximo de 512 MB de memória e uso de CPU equivalente a um processador.
-------------------------------------
Esses valores representam limites máximos, não consumo obrigatório.