#!/bin/bash

#      _____           _        _ _                                           
#     |_   _|         | |      | | |                                         
#       | |  _ __  ___| |_ __ _| | | 
#       | | | '_ \/ __| __/ _` | | |
#      _| |_| | | \__ \ || (_| | | |
#     |_____|_| |_|___/\__\__,_|_|_|
#           _   _  _____ _____ _   ___   __
#          | \ | |/ ____|_   _| \ | \ \ / /
#          |  \| | |  __  | | |  \| |\ V / 
#          | . ` | | |_ | | | | . ` | > <  
#          | |\  | |__| |_| |_| |\  |/ . \ 
#          |_| \_|\_____|_____|_| \_/_/ \_\

echo '=============================================================> INSTALLING NGINX'

set -x    

echo "NAMESPACE: ${NAMESPACE}"
echo "KUBERNETES_FOLDER: ${KUBERNETES_FOLDER}"
echo "KUBE_CONFIG: ${KUBE_CONFIG}"

export KUBECONFIG=${KUBE_CONFIG}

kubectl get nodes

# Nginx...

kubectl create namespace ${NAMESPACE}

kubectl apply --filename ${KUBERNETES_FOLDER}/nginx-deployment.yaml --namespace ${NAMESPACE}

kubectl expose deployment nginx-deployment --type=NodePort --name=nginx-service --namespace=${NAMESPACE}

set +x

echo '=========================================================> NGINX INSTALLED - OK'

exit 0