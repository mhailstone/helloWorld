#!/bin/bash -ex

#copy files to k8s server
scp rc.yml adm.mdh26@tabura1.byu.edu:
scp svc.yml adm.mdh26@tabura1.byu.edu:
ssh adm.mdh26@tabura1.byu.edu scp rc.yml atom1-prd:
ssh adm.mdh26@tabura1.byu.edu scp svc.yml atom1-prd:

ssh adm.mdh26@tabura1.byu.edu ssh atom1-prd << EOF

kubectl rolling-update hello-world-controller --image=hub-tmp.byu.edu/jgubler/hello-world:latest
kubectl create -f rc.yml
kubectl create -f svc.yml

EOF
