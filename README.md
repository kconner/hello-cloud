# hello-cloud

## Assumptions

You are using macOS 10.15 Catalina.

## Setup

Install [Docker for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac/).

Install [Homebrew](https://brew.sh).

### Python environment

This project uses Python for scripts not included in deployable Docker images,
so requires some local Python environment setup.
We use `pyenv` in order to avoid interfering with other applications.

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

Optionally, get instructions for setting your python environment automatically,
so you don't have to prefix commands like `pip` with `pyenv exec`.
For instance, you can then run scripts as `scripts/foo.py` rather than
`pyenv exec python scripts/foo.py`.

```bash
pyenv init
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

I should use a tool like virtualenv to avoid littering the Python environment
with packages from this project: https://stackoverflow.com/a/41573588/10906

