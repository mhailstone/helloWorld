#!/bin/bash -ex

echo zero
mkdir -p ~/.docker
echo one
echo -e $DOCKERCFG | base64 -d > ~/.docker/config.json
echo two
docker build -t hub-tmp.byu.edu/jgubler/hello-world:latest .
echo three
docker push hub-tmp.byu.edu/jgubler/hello-world:latest
echo four
