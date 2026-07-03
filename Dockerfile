FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    clang \
    llvm \
    pkg-config \
    libcurl4-openssl-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN curl -fsSL https://raw.githubusercontent.com/jishith-dev/Zen/main/install.sh | bash

EXPOSE 8080

CMD ["zen", "run", "server.zen"]
