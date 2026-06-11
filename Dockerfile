FROM mirror.gcr.io/library/gradle:4.10.3-jdk8 AS builder
WORKDIR /app
COPY build.gradle settings.gradle* gradle.properties* ./
COPY src ./src
RUN gradle jarAll -x test --no-daemon -q

FROM mirror.gcr.io/library/eclipse-temurin:11-jre-focal
WORKDIR /app
COPY --from=builder /app/build/libs/*-standalone.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-XX:+UseContainerSupport", "-jar", "app.jar"]
