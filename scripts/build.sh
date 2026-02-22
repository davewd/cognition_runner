#!/usr/bin/env bash
# build.sh - Build all cognition_runner Docker images.
# Usage: ./scripts/build.sh [--tag-prefix <prefix>]
#
# By default images are tagged as:
#   cognition_runner/python:latest
#   cognition_runner/swift:latest
#   cognition_runner/node:latest

set -euo pipefail

TAG_PREFIX="${TAG_PREFIX:-cognition_runner}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

build_image() {
    local name="$1"
    local context="${REPO_ROOT}/docker/${name}"
    local tag="${TAG_PREFIX}/${name}:latest"
    echo "==> Building ${tag} from ${context}"
    docker build --tag "${tag}" "${context}"
    echo "==> Successfully built ${tag}"
}

build_image python
build_image swift
build_image node

echo ""
echo "All images built successfully."
