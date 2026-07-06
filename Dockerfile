FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.local/bin:${PATH}"

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    pkg-config \
    libcurl4-openssl-dev \
    build-essential \
    software-properties-common \
    lsb-release \
    wget \
    gnupg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install LLVM 20
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" -- 20

# Create unversioned LLVM tool symlinks
RUN ln -sf /usr/bin/clang-20 /usr/bin/clang && \
    ln -sf /usr/bin/clang++-20 /usr/bin/clang++ && \
    ln -sf /usr/bin/llc-20 /usr/bin/llc && \
    ln -sf /usr/bin/opt-20 /usr/bin/opt && \
    ln -sf /usr/bin/llvm-config-20 /usr/bin/llvm-config

WORKDIR /app

COPY . .

# Install Zen
RUN curl -fsSL https://raw.githubusercontent.com/jishith-dev/Zen/main/install.sh | bash

EXPOSE 8080

CMD ["zen", "run", "main.zen"]
