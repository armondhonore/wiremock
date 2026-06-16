FROM mirror.gcr.io/library/gradle:6.9-jdk8 AS builder
WORKDIR /app
# Cache dependencies layer
COPY build.gradle settings.gradle* gradle.properties* ./ 
COPY gradle ./gradle
COPY gradlew ./
RUN chmod +x gradlew
# Pre-fetch dependencies to optimize build time
RUN ./gradlew dependencies --no-daemon -q || true
COPY src ./src
# Build the standalone JAR as per Operator Guidance
RUN ./gradlew jarAll -x test --no-daemon -q

FROM mirror.gcr.io/library/eclipse-temurin:11-jre-focal
WORKDIR /app
# Use glob to capture the standalone jar regardless of version
COPY --from=builder /app/build/libs/*-standalone.jar app.jar
# WireMock requires these directories for stubs and files
RUN mkdir -p mappings __files

EXPOSE 8080
# Explicitly bind to port 8080 to match Nexlayer routing
# Using --verbose for better observability in logs
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-XX:+UseContainerSupport", "-jar", "app.jar", "--port", "8080", "--verbose"]
