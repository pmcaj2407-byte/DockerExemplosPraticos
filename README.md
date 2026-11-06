# Minha app

Aplicacao Java simples que mostra a versao configurada em `APP_VERSION`.
O projeto usa Maven, Java 21 e Docker. Uma tag Git iniciada por `v` dispara
a publicacao da imagem no GitHub Container Registry (GHCR).

## Requisitos

- JDK 21
- Maven
- Docker (opcional, para executar em container)

## Compilar e executar com Maven

Na raiz do projeto:

```shell
mvn clean package
java -jar target/app.jar
```

Para definir a versao localmente:

```powershell
$env:APP_VERSION = "1.0.0"
java -jar target/app.jar
```

Sem `APP_VERSION`, a aplicacao mostra `dev`.

## Executar com Docker

```shell
docker build --build-arg VERSION=1.0.0 -t minha-app:1.0.0 .
docker run --rm minha-app:1.0.0
```

## Publicar no GitHub

Envie o projeto para um repositorio GitHub. O workflow em
`.github/workflows/publish-image.yml` publica a imagem quando uma tag de
versao e enviada, por exemplo:

```shell
git tag v1.0.0
git push origin v1.0.0
```

O workflow usa `GITHUB_TOKEN` para autenticar no GHCR; nao e necessario
cadastrar um token pessoal nos secrets do repositorio.
