#!/bin/bash

set -e
name=$(basename $(realpath $(dirname ${BASH_SOURCE[0]})))-$(id -un)
docker build --network host --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} \
             --build-arg USERNAME=$(id -un) --build-arg USERUID=$(id -u) --build-arg USERGID=$(id -g)   \
             --build-arg GIT_USER_NAME=$(git config --global --get user.name)                           \
             --build-arg GIT_USER_EMAIL=$(git config --global --get user.email)                         \
             -t ${name}:latest $(realpath $(dirname ${BASH_SOURCE[0]}))
