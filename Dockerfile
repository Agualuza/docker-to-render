FROM gradle:8.2.1-jdk17 AS builder

RUN git clone https://github.com/Agualuza/ebanx-code-challenge /app
WORKDIR /app

RUN chmod +x ./gradlew

RUN ./gradlew build --no-daemon

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE $PORT

CMD ["java", "-jar", "app.jar"]