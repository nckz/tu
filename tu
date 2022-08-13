#!/bin/bash
# Author: Nick Zwart
# Date: 2019dec30
# Brief: Try to determine a suitable working directory to volume mount before
#        starting the dockerized vim.
#

set -eo pipefail

########################################################################### CLI
AS_ROOT=${AS_ROOT:-}
ARGS=${ARGS:-}


####################################################################### INCLUDE
# TODO: inject these as part of the install
# make the docker tags for this project
DOCKER_ACC='3x3t3r'
DOCKER_REP='tu'
DOCKER_TAG='latest'
DOCKER_REF="${DOCKER_ACC}/${DOCKER_REP}"


TERM="bash"


########################################################################## MAIN
# assume the user will only give one arg and that it will be a file or
# directory path.
MNT=$('pwd')  # by default use the current working dir

# allow the internal container user to be root
AS_USER="--user $(id -u):$(id -g)"
[ -n "${AS_ROOT}" ] && AS_USER="--user 0:0"

# if no args are given then mount the current directory
echo "USER: ${AS_USER}, CWD: ${MNT}, CMD: $@"

# set interactive mode
INTERACTIVE=""
if [ "$@" = "${TERM}" ]; then
    INTERACTIVE="-it"
    echo "Interactive Shell"
fi

# change detach keys from ctrl-p to something less obtrusive to vim
time docker run ${ARGS} --rm ${INTERACTIVE} --detach-keys="ctrl-@" -v ${MNT}:/workdir ${AS_USER} "${DOCKER_REF}" "$@"
