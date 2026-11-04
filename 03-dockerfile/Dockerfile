# ---------- Estágio 1: Build (Maven + JDK) ----------
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /build

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn package -DskipTests -B

# ---------- Estágio 2: Execução (Apenas JRE enxuto) ----------
FROM eclipse-temurin:21-jre
WORKDIR /app

RUN useradd --system --create-home appuser
USER appuser

COPY --from=build /build/target/app.jar app.jar

ENV JAVA_OPTS=""
ENTRYPOINT ["java", "-jar", "app.jar"]