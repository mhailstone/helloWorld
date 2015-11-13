#!/bin/bash -ex

mkdir -p ~/.ssh/
echo -e $PRIVATE_TABURA_SSH_KEY | base64 -d -o ~/.ssh/id_codeship_rsa
chmod 600 ~/.ssh/id_codeship_rsa

#copy files to k8s server
scp -i ~/.ssh/id_codeship_rsa -P 22222 -o StrictHostKeyChecking=no rc.yml adm.mdh26@tabura.byu.edu:
scp -i ~/.ssh/id_codeship_rsa -P 22222 -o StrictHostKeyChecking=no svc.yml adm.mdh26@tabura.byu.edu:
ssh -i ~/.ssh/id_codeship_rsa -p 22222 -o StrictHostKeyChecking=no adm.mdh26@tabura.byu.edu "scp -i ~/.ssh/codeship_rsa rc.yml dockeru@atom1-prd.byu.edu:"
ssh -i ~/.ssh/id_codeship_rsa -p 22222 -o StrictHostKeyChecking=no adm.mdh26@tabura.byu.edu "scp -i ~/.ssh/codeship_rsa svc.yml dockeru@atom1-prd.byu.edu:"

ssh -i ~/.ssh/id_codeship_rsa -o StrictHostKeyChecking=no adm.mdh26@tabura.byu.edu ssh -i ~/.ssh/codeship_rsa dockeru@atom1-prd.byu.edu << EOF

kubectl rolling-update hello-world-controller --image=hub-tmp.byu.edu/jgubler/hello-world:latest
kubectl create -f rc.yml
kubectl create -f svc.yml

rm rc.yml
rm svc.yml
EOF
