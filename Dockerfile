FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Base packages
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
    && rm -rf /var/lib/apt/lists/*

# Install LLVM 20
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" -- 20

WORKDIR /app
COPY . .

RUN curl -fsSL https://raw.githubusercontent.com/jishith-dev/Zen/main/install.sh | bash

EXPOSE 8080

CMD ["zen", "run", "server.zen"]
