# Nexlayer — wiremock

<!-- nexlayer:meta version=1 analyzed=2026-06-10T15:41:21Z repo=https://github.com/armondhonore/wiremock branch=master -->

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
WireMock is a HTTP web service test double that allows for response stubbing, request verification, and fault injection. It can be run as a standalone process, within unit tests, or as a WAR application.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Java | language | 1.6 | build.gradle |
| Jetty | framework | 6.1.26 | build.gradle |
| Gradle | build | Not specified | build.gradle |
| JUnit | tool | 4.11 | build.gradle |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- src/ — Main application source code
- docs/ — Project documentation
- sample-war/ — Example WAR deployment configuration
- build.gradle — Gradle build configuration and dependency management
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
_No external services detected._
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- JDK 1.6 (or compatible)
- Gradle

### Steps

1. `./gradlew build` — Compile the project and run tests
2. `java -jar build/libs/wiremock-standalone.jar` — Start WireMock as a standalone server

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `JAVA_OPTS` | `"-XX:MaxRAMPercentage=75.0 -XX:+UseContainerSupport"` | plain |

### nexlayer.yaml

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

<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| wiremock | mirror.gcr.io/library/openjdk:8-jre-alpine | 8080 | web |

### Deployment notes

- The project is legacy Java 1.6; using openjdk:8-jre-alpine for runtime compatibility as it is the most stable mirrored image supporting legacy bytecode.
- Since WireMock is a stateless mock server, it runs as a single pod without a database requirement.

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-10T15:47:34Z  
**Live URL:** https://awesome-moose-warm-vale-wiremock.cloud.nexlayer.ai  
**Runtime:** java · **Port:** 8080  
**Deploy branch:** master  

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
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-10T15:41:21Z | analyzed | initial repo analysis |
| 2026-06-10T15:47:34Z | success | deployed https://awesome-moose-warm-vale-wiremock.cloud.nexlayer.ai |
<!-- nexlayer:end -->
