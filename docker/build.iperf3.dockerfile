FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    gcc \
    git \
    autoconf \
    automake \
    libtool \
    libssl-dev \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
    bear \
    clangd-12

# https://clangd.llvm.org/installation.html
RUN update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100

WORKDIR /iperf3
