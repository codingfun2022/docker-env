#!/bin/bash

set -e
name=$(basename $(realpath $(dirname ${BASH_SOURCE[0]})))-$(date +"%Y-%m-%d")
tag=$(sha1sum $(realpath $(dirname ${BASH_SOURCE[0]}))/Dockerfile | awk '{print substr($1,1,7)}')
docker build --network host --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} \
             -t ${name}-${tag}:latest $(realpath $(dirname ${BASH_SOURCE[0]}))
