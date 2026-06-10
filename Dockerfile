FROM mirror.gcr.io/library/gradle:8-jdk21 AS builder
WORKDIR /app
COPY build.gradle* settings.gradle* gradle.properties* ./
COPY gradle ./gradle
COPY gradlew ./
RUN chmod +x gradlew
RUN ./gradlew dependencies --no-daemon -q 2>/dev/null || true
COPY src ./src
RUN ./gradlew jarAll -x test --no-daemon -q

FROM gcr.io/distroless/java21-debian12
WORKDIR /app
COPY --from=builder /app/build/libs/*-standalone.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-XX:+UseContainerSupport", "-jar", "app.jar"]