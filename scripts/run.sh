#!/usr/bin/env bash
# run.sh - Execute a command inside a cognition_runner container.
#
# Usage:
#   ./scripts/run.sh <image-name> [--workdir <path>] -- <command> [args...]
#
# Examples:
#   ./scripts/run.sh python -- pytest tests/
#   ./scripts/run.sh python -- black --check src/
#   ./scripts/run.sh node -- npm test
#   ./scripts/run.sh swift -- swift build
#
# The host current-working-directory is mounted at /workspace inside the
# container and used as the working directory by default.  stdout and stderr
# from the container are forwarded directly to the calling process.
#
# Environment variables:
#   TAG_PREFIX   Image name prefix (default: cognition_runner)
#   WORKDIR      Path on the host to mount (default: $PWD)

set -euo pipefail

TAG_PREFIX="${TAG_PREFIX:-cognition_runner}"
WORKDIR="${WORKDIR:-$(pwd)}"

usage() {
    echo "Usage: $(basename "$0") <image-name> [--workdir <host-path>] -- <command> [args...]" >&2
    exit 1
}

if [[ $# -lt 1 ]]; then
    usage
fi

IMAGE_NAME="$1"; shift

# Parse optional --workdir flag before the -- separator
while [[ $# -gt 0 ]]; do
    case "$1" in
        --workdir)
            WORKDIR="$2"; shift 2 ;;
        --)
            shift; break ;;
        *)
            break ;;
    esac
done

if [[ $# -eq 0 ]]; then
    echo "Error: no command specified" >&2
    usage
fi

FULL_IMAGE="${TAG_PREFIX}/${IMAGE_NAME}:latest"

# Run the command inside the container.
# stdout and stderr are inherited from the calling process (default docker behaviour).
docker run --rm \
    --volume "${WORKDIR}:/workspace" \
    --workdir /workspace \
    "${FULL_IMAGE}" \
    "$@"
