# hello-cloud

## Assumptions

You are using macOS 10.15 Catalina.

## Setup

Install [Docker for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac/).

Install [Homebrew](https://brew.sh).

Install `pyenv` with `brew`.

```bash
brew install pyenv
```

Install the project's version of Python with `pyenv`.

```bash
pyenv install
```

Update `pip` and install `pip` packages.

```bash
pyenv exec pip install --upgrade pip --requirement requirements.txt
```

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
curl http://localhost:8080/health-check/
```

When done, tear it down.

```bash
docker-compose down
```

## Things I want to find a home for

Use `dive` to inspect docker images you create.

```bash
brew install dive
dive <image>
```

