FROM ubuntu:kinetic
MAINTAINER Nick Zwart <dr.nicky.z@gmail.com>

# install all desired tools
RUN apt-get update && apt-get --no-install-recommends --yes install \
    cbm \
    cloc \
    curl \
    git \
    htop \
    iperf \
    jq \
    less \
    net-tools \
    pandoc \
    python3 \
    python3-pip \
    screen \
    snapd \
    speedtest-cli \
    texlive-xetex \
    vim \
    wget

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
