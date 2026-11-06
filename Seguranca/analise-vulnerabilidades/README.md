
# Análise de vulnerabilidades em imagens Docker

# OBJETIVO

Demonstrar como identificar vulnerabilidades conhecidas em uma imagem Docker utilizando o Docker Scout, permitindo avaliar os riscos associados aos componentes e dependências utilizados pela aplicação.

# ARQUIVOS

Este exemplo reutiliza o Dockerfile localizado em `seguranca/usuario-nao-root/` para construir uma imagem que será analisada.

Os comandos para construir a imagem e realizar a análise são executados diretamente no terminal, a partir da raiz do repositório:

```bash
docker build -t exemplo-non-root ./seguranca/usuario-nao-root

docker scout cves local://exemplo-non-root
```

# FUNCIONAMENTO

O Docker Scout é uma ferramenta que analisa imagens Docker em busca de vulnerabilidades conhecidas em seus componentes, como pacotes do sistema operacional e dependências.

Durante a análise, a ferramenta utiliza informações sobre os componentes presentes na imagem, organizadas em um inventário conhecido como SBOM (*Software Bill of Materials*), e verifica possíveis vulnerabilidades conhecidas.

No exemplo apresentado:

- `docker build`: constrói uma imagem Docker utilizando o Dockerfile indicado.
- `-t`: define o nome da imagem criada.
- `./seguranca/usuario-nao-root/`: indica o diretório que contém o Dockerfile.
- `docker scout cves`: executa a análise de vulnerabilidades.
- `local://`: indica que a imagem analisada está disponível localmente.
- `exemplo-non-root`: identifica a imagem que será analisada.

Os resultados podem apresentar identificadores de vulnerabilidades (CVEs), níveis de severidade e informações sobre versões corrigidas.

# COMO EXECUTAR

A partir da raiz do repositório, construir a imagem:

```bash
docker build -t exemplo-non-root ./seguranca/usuario-nao-root
```

Realizar a análise de vulnerabilidades:

```bash
docker scout cves local://exemplo-non-root
```

# RESULTADO ESPERADO

O Docker Scout apresentará um relatório com as vulnerabilidades conhecidas identificadas nos componentes da imagem, organizadas conforme seus níveis de severidade.
-------------------------------------

A quantidade e a classificação das vulnerabilidades podem variar conforme as versões dos componentes e as atualizações das bases de dados utilizadas pela ferramenta.

Caso sejam identificadas vulnerabilidades, recomenda-se avaliar os riscos, atualizar os componentes afetados quando houver correções disponíveis, reconstruir a imagem e realizar uma nova análise.

É importante destacar que a ausência de vulnerabilidades identificadas não garante que a imagem seja completamente segura.