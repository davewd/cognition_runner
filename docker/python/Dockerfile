FROM python:3.12.9-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    pre-commit \
    pytest \
    isort \
    flake8 \
    black

WORKDIR /workspace

ENTRYPOINT []
CMD ["/bin/bash"]
