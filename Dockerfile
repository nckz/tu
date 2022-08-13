FROM ubuntu:kinetic
MAINTAINER Nick Zwart <dr.nicky.z@gmail.com>

# BASIC TOOLS
RUN apt-get update && apt-get --no-install-recommends --yes install \
    binutils \
    build-essential \
    cbm \
    cloc \
    curl \
    git \
    htop \
    iperf \
    jq \
    less \
    net-tools \
    nmap \
    pandoc \
    python3 \
    python3-pip \
    python3-dev \
    screen \
    snapd \
    speedtest-cli \
    tree \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

# BLOG
RUN apt-get update && apt-get --no-install-recommends --yes install \
    hugo \
    && rm -rf /var/lib/apt/lists/*

# LATEX
RUN apt-get update && apt-get --no-install-recommends --yes install \
    texlive-xetex \
    && rm -rf /var/lib/apt/lists/*

# ISMRM
RUN apt-get update && apt-get --no-install-recommends --yes install \
    libenchant-2-2 \
    libenchant-2-dev \
    && rm -rf /var/lib/apt/lists/*

# archive.ismrm.org
RUN pip3 install \
    beautifulsoup4 \
    joblib \
    lxml \
    matplotlib \
    numpy \
    pillow \
    pyenchant \
    stop-words \
    wget \
    wordcloud

# manual installs
ARG VERSION=v4.2.0
ARG BINARY=yq_linux_amd64
RUN wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY} -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

# copy the entrypoint script
COPY entrypoint /

# for performing git commands from vim
COPY gitconfig /etc/gitconfig

# make a working directory
RUN mkdir -p /workdir

# do initial vim setup
ENTRYPOINT ["/entrypoint"]
