FROM gradle:8.2.1-jdk17 AS builder

RUN git clone https://github.com/Agualuza/ebanx-code-challenge /app
WORKDIR /app

RUN gradle build --no-daemon

FROM openjdk:17-jdk-slim

COPY --from=builder /app/build/libs/*.jar /app/app.jar

WORKDIR /app

EXPOSE $PORT

CMD ["java", "-jar", "app.jar"]