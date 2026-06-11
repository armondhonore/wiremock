# Nexlayer Fix

## Fixed Dockerfile
```dockerfile
FROM mirror.gcr.io/library/gradle:6.9-jdk8 AS builder
WORKDIR /app
COPY build.gradle settings.gradle* gradle.properties* ./
COPY src ./src
RUN gradle jarAll -x test --no-daemon -q

FROM mirror.gcr.io/library/eclipse-temurin:11-jre-focal
WORKDIR /app
COPY --from=builder /app/build/libs/*-standalone.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-XX:+UseContainerSupport", "-jar", "app.jar"]
```

## Fixed nexlayer.yaml
```yaml
application:
  name: warm-vale-wiremock
  pods:
    - name: app
      image: "# filled by pipeline"
      path: /
      servicePorts:
        - 8080
      vars:
        JAVA_OPTS: "-XX:MaxRAMPercentage=75.0 -XX:+UseContainerSupport"
```

## Notes
- build.gradle uses `<<` (leftShift) task syntax removed in Gradle 5.0 — must use Gradle 4.x
- build.gradle uses `compile` config and `apply plugin: 'maven'` removed in Gradle 7 — must use Gradle <= 6.x
- Combined constraint: Gradle 4.10.3 (last 4.x release)
- Use system `gradle` binary from the base image — DO NOT use ./gradlew (wrapper pins Gradle 1.11 which fails to download in Kaniko)
- DO NOT use Gradle 5+ — leftShift removed
- DO NOT use Gradle 7+ — maven plugin removed
- build.gradle jarAll task's project.artifacts.add() with map-cast-as-PublishArtifact fails in Gradle 4.x due to internal decoration changes; that block was removed (only needed for Maven publishing, not Docker deployment)
