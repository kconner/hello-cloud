# hello-cloud

## Assumptions

You are using macOS 10.15 Catalina.

## Setup

Install [Docker for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac/).

## Workflow

Bring up a debug environment with Docker Compose.

```bash
docker-compose up --build --detach
```

Alternatively, perform a release build and then launch that.

```bash
docker-compose --file docker-compose.release.yml up --build --detach
```

In either case, find the server at port 8080.

```bash
curl http://localhost:8080
```

When done, tear it down.

```bash
docker-compose down
```

## Things I want to find a home for

Use `dive` to inpsect docker images you create.

```bash
brew install dive
dive <image>
```
