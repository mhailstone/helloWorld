#!/bin/bash -ex

mkdir -p ~/.docker
echo -e $DOCKERCFG | base64 -d > ~/.docker/config.json
docker build -t hub-tmp.byu.edu/jgubler/hello-world:latest .
docker push hub-tmp.byu.edu/jgubler/hello-world:latest
