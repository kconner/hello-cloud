# hello-cloud

In this hobby project, I'm experimenting with a backend app made of Docker
container services that can each be switched between multiple implementations,
but which work in any combination due to being well-factored.
The goal is to have a place to try out new tools that interest me,
and to find patterns that work well regardless of the tools.

The app runs in `docker-compose`, so it should be realistically deployable.
(For a real product, it would be better to work backward from real deployed
resources toward a local simulation.) In debug mode, built images include
build tools and hot reloading, while in release mode they include
only what you'd want to ship.

To select service implementations and debug or release mode, you configure
the app using a script. Configuring generates `docker-compose.yml`.

So far, the services and their implementations are:

- `api`
    - [`python3-flask`](https://palletsprojects.com/p/flask/)
    - [`swift-vapor`](https://vapor.codes) 
    - [`go-gorilla`](https://www.gorillatoolkit.org) 

## Setup

These instructions assume you are using macOS 10.15 Catalina.

Install [Docker for Mac](
    https://hub.docker.com/editions/community/docker-ce-desktop-mac/
), a menu bar app and system service for running containers.

Install [Homebrew](https://brew.sh), the macOS community package manager.

### Python script environment

This project uses Python for scripts run outside of Docker.
We use `pyenv` to keep our mess out of other projects.
This requires some local environment setup.

Install `pyenv` using `brew`.

```bash
brew install pyenv
```

Install the project's version of Python using `pyenv`.

```bash
pyenv install
```

Update `pip` and install `pip` packages.

```bash
pyenv exec pip install --upgrade pip --requirement scripts/requirements.txt
```

Get instructions for using `pyenv` in terminal sessions, then follow them.
Start a new terminal tab to apply.

```bash
pyenv init
```

> This will remove the need to prefix python environment commands with
> `pyenv exec`. This is necessary for running scripts as they're written here.

## Workflow

Select an app configuration and write docker-compose.yml.

```bash
./scripts/configure.py --mode debug --api python3-flask
```

> Scripts are generally written to be run from the project root folder.

Bring up a debug environment with Docker Compose.

```bash
docker-compose up --build --detach
```

Find the API service at port 8080.

```bash
curl http://localhost:8080/health-check/
```

When done, tear it down.

```bash
docker-compose down
```

If you like, you can remove all script output.

```bash
./scripts/clean.sh
```

## Things I want to find a home for

Use `dive` to inspect docker images you create.

```bash
brew install dive
dive <image>
```

I should use a tool like virtualenv to avoid littering the Python environment
with packages from this project: https://stackoverflow.com/a/41573588/10906

