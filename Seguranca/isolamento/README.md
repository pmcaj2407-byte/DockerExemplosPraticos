
# Isolamento de processos entre containers

# OBJETIVO

Demonstrar como o Docker utiliza o isolamento de processos para manter a execução de diferentes containers em ambientes separados, utilizando o PID Namespace do kernel Linux.

# ARQUIVOS

Este exemplo não utiliza arquivos próprios. Todos os comandos para criar os containers, verificar seus processos e removê-los são executados diretamente no terminal:

docker run -d --name container-a alpine:3.20 sleep 300

docker run -d --name container-b alpine:3.20 sleep 300

docker exec container-a ps

docker exec container-b ps

docker rm -f container-a container-b

# FUNCIONAMENTO

O Docker utiliza Namespaces para isolar a visão que os processos de cada container possuem dos recursos do sistema.

Neste exemplo, o PID Namespace proporciona uma visão independente dos processos em execução em cada container.

`docker run`: cria e inicia um container.
`-d`: executa o container em segundo plano.
`--name`: define o nome do container.
`alpine`:3.20: define a imagem utilizada.
`sleep 300`: mantém um processo em execução durante 300 segundos.
`docker exec`: permite executar um comando dentro de um container que já está em execução.
`ps`: apresenta os processos visíveis dentro do ambiente em que é executado.
`docker rm -f`: remove os containers indicados, forçando sua parada caso ainda estejam em execução.

# COMO EXECUTAR

Criar e iniciar os dois containers:

```bash
docker run -d --name container-a alpine:3.20 sleep 300

docker run -d --name container-b alpine:3.20 sleep 300
```

Verificar os processos do primeiro container:

```bash
docker exec container-a ps
```

Verificar os processos do segundo container:

```bash
docker exec container-b ps
```

Remover os containers após o teste:

```bash
docker rm -f container-a container-b
```

# RESULTADO ESPERADO

Ao executar o comando `ps` em cada container, serão apresentados os processos visíveis naquele ambiente, incluindo o processo `sleep` iniciado durante sua criação.
-------------------------------------

Cada container terá sua própria visão dos processos, sem visualizar normalmente os processos pertencentes ao outro container ou ao sistema hospedeiro.

Dessa forma, o exemplo demonstra o isolamento de processos proporcionado pelo PID Namespace.