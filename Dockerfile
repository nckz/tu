FROM ubuntu:kinetic
MAINTAINER Nick Zwart <dr.nicky.z@gmail.com>

# install all desired tools
RUN apt-get update && apt-get --no-install-recommends --yes install \
    git \
    vim \
    python3 \
    python3-pip \
    less

# copy the entrypoint script
COPY entrypoint /

# for performing git commands from vim
COPY gitconfig /etc/gitconfig

# make a working directory
RUN mkdir -p /workdir

# do initial vim setup
ENTRYPOINT ["/entrypoint"]
