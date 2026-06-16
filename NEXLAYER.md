# Nexlayer — wiremock

<!-- nexlayer:meta version=1 analyzed=2026-06-16T00:00:38Z repo=https://github.com/armondhonore/wiremock branch=master -->

> **For AI agents (Claude Code, Cursor, Gemini CLI, Copilot):**
> This file is the **project context** for this Nexlayer deployment — tech stack, env vars, secrets, live URL.
> For full platform detail (nexlayer.yaml schema, Dockerfile rules, CI/CD, task recipes) read **`nexlayer.skills`** in this repo.
>
> **Critical rules (full detail in `nexlayer.skills`):**
> - Inter-pod refs: `${podName:port}` only — never `localhost` or bare hostnames
> - Docker Hub images: prefix with `mirror.gcr.io/library/` — bare tags fail on the cluster
> - Secrets: set in the Nexlayer dashboard — never commit to `nexlayer.yaml` or Dockerfile
>
> **This file:** `agent-managed` sections update automatically. `user-editable` sections (Local Development Setup, Nexlayer Deployment Plan, Build Notes) are yours — preserved across re-analysis.

## Project Summary
<!-- nexlayer:section agent-managed=project_summary -->
WireMock is a HTTP web service test double that allows for request stubbing, verification, and fault injection. It can run as a standalone process, a unit test tool, or a WAR application.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Java | language | 1.6 | build.gradle |
| Gradle | build | 6.9 | Dockerfile |
| Jetty | framework | 6.1.26 | build.gradle |
| Jackson | tool | 2.4.2 | build.gradle |
| Guava | tool | 18.0 | build.gradle |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- src/ — Java source code for the core WireMock library
- docs/ — Project documentation
- sample-war/ — Example configuration for deploying as a WAR file
- build.gradle — Project build configuration and dependencies
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
_No external services detected._
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- JDK 8 or 11
- Gradle 6.9+

### Steps

1. `./gradlew jarAll` — Build the standalone executable JAR
2. `java -jar build/libs/wiremock-standalone.jar` — Start WireMock server on http://localhost:8080

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `wiremock` | `JAVA_OPTS` | `"-XX:MaxRAMPercentage=75.0 -XX:+UseContainerSupport"` | plain |

### nexlayer.yaml

```yaml
application:
  name: warm-vale-wiremock
  pods:
    - name: wiremock
      image: "# filled by pipeline"
      path: /
      servicePorts:
        - 8080
      vars:
        JAVA_OPTS: "-XX:MaxRAMPercentage=75.0 -XX:+UseContainerSupport"
```

<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| wiremock | mirror.gcr.io/library/eclipse-temurin:11-jre-focal | 8080 | web |

### Deployment notes

- Single pod deployment as the application is a stateless test double.
- Image follows Nexlayer mirror.gcr.io guidelines for official libraries.

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-16T00:27:04Z  
**Live URL:** https://awesome-moose-warm-vale-wiremock.cloud.nexlayer.ai  
**Runtime:** java · **Port:** 8080  
**Deploy branch:** master  

```yaml
application:
  name: warm-vale-wiremock
  pods:
    - name: wiremock
      image: "# filled by pipeline"
      path: /
      servicePorts:
        - 8080
      vars:
        JAVA_OPTS: "-XX:MaxRAMPercentage=75.0 -XX:+UseContainerSupport"
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-16T00:00:38Z | analyzed | initial repo analysis |
| 2026-06-16T00:27:04Z | success | deployed https://awesome-moose-warm-vale-wiremock.cloud.nexlayer.ai |
<!-- nexlayer:end -->
