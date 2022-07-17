#!/bin/bash
# Author: Nick Zwart
# Date: 2019dec30
# Brief: Try to determine a suitable working directory to volume mount before
#        starting the dockerized vim.

set -eo pipefail

####################################################################### INCLUDE
# TODO: inject these as part of the install
# make the docker tags for this project
DOCKER_ACC='3x3t3r'
DOCKER_REP='tu'
DOCKER_TAG='latest'
DOCKER_REF="${DOCKER_ACC}/${DOCKER_REP}"


########################################################################## MAIN
# assume the user will only give one arg and that it will be a file or
# directory path.
MNT=$('pwd')  # by default use the current working dir

# if no args are given then mount the current directory
echo "CWD: ${MNT}, CMD: $@"

# change detach keys from ctrl-p to something less obtrusive to vim
docker run --rm --detach-keys="ctrl-@" -v ${MNT}:/workdir "${DOCKER_REF}" "$@"
