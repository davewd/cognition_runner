FROM swift:5.10.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir --break-system-packages pre-commit

WORKDIR /workspace

ENTRYPOINT []
CMD ["/bin/bash"]
