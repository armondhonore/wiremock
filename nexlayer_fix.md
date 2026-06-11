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
The gradle-wrapper.properties pinned Gradle 1.11 whose zip download fails in Kaniko (ZipException).
The build.gradle uses legacy `compile` configuration and `apply plugin: 'maven'` — requires Gradle <= 6.x (removed in Gradle 7).
Fix: use the pre-installed system `gradle` binary from the gradle:6.9-jdk8 base image — no wrapper download at all.
DO NOT use ./gradlew — even with the updated wrapper (now 6.9.4), the system gradle is more reliable in Kaniko.
DO NOT use Gradle 7+ — the maven plugin was removed and this build.gradle depends on it.
