#!/usr/bin/env bash
set -x

DOCKER_SOCKET=/var/run/docker.sock
DOCKER_GROUP=docker
REGULAR_USER=jenkins

if [ -S ${DOCKER_SOCKET} ]; then
    groupdel ${DOCKER_GROUP} || true
    DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
    groupadd -for -g ${DOCKER_GID} ${DOCKER_GROUP}
    usermod -aG ${DOCKER_GROUP} ${REGULAR_USER}
fi

# Change to regular user and run the rest of the entry point
su ${REGULAR_USER} -c "/usr/bin/env jenkins-slave ${*}"
