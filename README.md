# cognition_runner

Docker containers that provide isolated, reproducible development environments
for automating coding tasks with LLMs.  Each image pre-installs the language
runtime, development tools, and `git`/`pre-commit` for version control hooks.

## Repository layout

```
cognition_runner/
├── docker/
│   ├── python/   # Python image (pytest, isort, flake8, black)
│   ├── swift/    # Swift image  (swift build, swift test)
│   └── node/     # Node.js image (npm)
└── scripts/
    ├── build.sh  # Build all images
    └── run.sh    # Run a command inside a container
```

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running.

## Building images

```bash
./scripts/build.sh
```

This builds all three images and tags them as:

| Image | Tag |
|---|---|
| Python | `cognition_runner/python:latest` |
| Swift  | `cognition_runner/swift:latest`  |
| Node   | `cognition_runner/node:latest`   |

Set `TAG_PREFIX` to override the default namespace:

```bash
TAG_PREFIX=myorg ./scripts/build.sh
```

## Running commands in a container

```bash
./scripts/run.sh <image-name> [--workdir <host-path>] -- <command> [args...]
```

The current working directory is mounted at `/workspace` inside the container.
`stdout` and `stderr` from the containerised command are forwarded directly to
the calling process.

### Examples

```bash
# Python
./scripts/run.sh python -- pytest tests/
./scripts/run.sh python -- black --check src/
./scripts/run.sh python -- isort --check-only .
./scripts/run.sh python -- flake8 src/

# Swift
./scripts/run.sh swift -- swift build
./scripts/run.sh swift -- swift test

# Node.js
./scripts/run.sh node -- npm install
./scripts/run.sh node -- npm test

# Use a specific host directory
./scripts/run.sh python --workdir /path/to/project -- pytest
```

## Tools available in every image

| Tool | Purpose |
|---|---|
| `git` | Version control |
| `pre-commit` | Git hook management |

## Per-image tools

| Image | Additional tools |
|---|---|
| Python | `python`, `pytest`, `isort`, `flake8`, `black` |
| Swift  | `swift` (build + test) |
| Node   | `node`, `npm` |
