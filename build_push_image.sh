#!/bin/bash -ex

mkdir -p ~/.docker
echo -e $DOCKERCFG | base64 -d > ~/.docker/config.json
docker build -t hubtmp.byu.edu/jgubler/hello-world:latest .
docker push hubtmp.byu.edu/jgubler/hello-world:latest
