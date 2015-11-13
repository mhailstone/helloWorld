#!/bin/bash

kubectl rolling-update hello-world-controller --image=hubtmp.byu.edu/jgubler/hello-world:latest
kubectl create -f rc.yml
kubectl create -f svc.yml

rm rc.yml
rm svc.yml
rm kubectl-commands.sh