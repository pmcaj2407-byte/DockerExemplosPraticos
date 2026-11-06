FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B -ntp clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app

ARG VERSION=dev
ARG REVISION=local
ARG SOURCE=""
LABEL org.opencontainers.image.source="${SOURCE}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${REVISION}"

ENV APP_VERSION=${VERSION}
COPY --from=build /app/target/app.jar app.jar
USER 1000
CMD ["java", "-jar", "app.jar"]
