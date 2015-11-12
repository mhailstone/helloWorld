#!/bin/bash -ex

mkdir -p ~/.ssh/
echo -e $PRIVATE_TABURA_SSH_KEY > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

#copy files to k8s server
scp -P 22222 -o StrictHostKeyChecking=no rc.yml adm.mdh26@tabura1.byu.edu:
scp -P 22222 -o StrictHostKeyChecking=no svc.yml adm.mdh26@tabura1.byu.edu:
ssh -p 22222 -o StrictHostKeyChecking=no adm.mdh26@tabura1.byu.edu scp -i ~/.ssh/codeship_rsa rc.yml atom1-prd:
ssh -p 22222 -o StrictHostKeyChecking=no adm.mdh26@tabura1.byu.edu scp -i ~/.ssh/codeship_rsa svc.yml atom1-prd:

ssh -o StrictHostKeyChecking=no adm.mdh26@tabura1.byu.edu ssh -i ~/.ssh/codeship_rsa shatom1-prd << EOF

kubectl rolling-update hello-world-controller --image=hub-tmp.byu.edu/jgubler/hello-world:latest
kubectl create -f rc.yml
kubectl create -f svc.yml

EOF
