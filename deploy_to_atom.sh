#!/bin/bash -ex

#copy files to k8s server
scp rc.yml adm.jgubler@tabura1.byu.edu:
scp svc.yml adm.jgubler@tabura1.byu.edu:
ssh adm.jgubler@tabura1.byu.edu scp rc.yml atom1-prd:
ssh adm.jgubler@tabura1.byu.edu scp svc.yml atom1-prd:

ssh adm.jgubler@tabura1.byu.edu ssh atom1-prd << EOF
#if rc doesn't exist
#...create rc
kubectl create -f rc.yml
#else
#...tell rc to update pods
kubectl rolling-update hello-world-controller --image=hub-tmp.byu.edu/jgubler/hello-world:latest
#if service doesn't exist
#...create service
kubectl create -f svc.yml

EOF
