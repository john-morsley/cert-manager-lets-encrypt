#!/usr/bin/env bash

#    _____           _        _ _    _____          _          __  __                                   
#   |_   _|         | |      | | |  / ____|        | |        |  \/  |                                  
#     | |  _ __  ___| |_ __ _| | | | |     ___ _ __| |_ ______| \  / | __ _ _ __   __ _  __ _  ___ _ __ 
#     | | | '_ \/ __| __/ _` | | | | |    / _ \ '__| __|______| |\/| |/ _` | '_ \ / _` |/ _` |/ _ \ '__|
#    _| |_| | | \__ \ || (_| | | | | |___|  __/ |  | |_       | |  | | (_| | | | | (_| | (_| |  __/ |   
#   |_____|_| |_|___/\__\__,_|_|_|  \_____\___|_|   \__|      |_|  |_|\__,_|_| |_|\__,_|\__, |\___|_|   
#                                                                                        __/ |          
#                                                                                       |___/                                                        

# Install Cert-Manager via Helm

#COMMON=$(pwd)/../common-kubernetes/scripts

#bash ${COMMON}/header.sh "INSTALL CERT-MANAGER"
echo "========================================================== INSTALL CERT-MANAGER"

#bash ${COMMON}/print_divider.sh

if [[ -z "${CERT_MANAGER_NAMESPACE}" ]]; then   
    echo "No CERT_MANAGER_NAMESPACE supplied."
    exit 666
fi
echo "CERT_MANAGER_NAMESPACE:" ${CERT_MANAGER_NAMESPACE}

if [[ -z "${KUBE_CONFIG}" ]]; then   
    echo "No KUBE_CONFIG supplied."
    exit 666
fi
echo "KUBE_CONFIG:" ${KUBE_CONFIG}

#bash ${COMMON}/print_divider.sh

export KUBECONFIG=${KUBE_CONFIG}

#kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.12/deploy/manifests/00-crds.yaml

kubectl create namespace ${CERT_MANAGER_NAMESPACE}

helm repo add jetstack https://charts.jetstack.io

helm repo update

#helm install cert-manager jetstack/cert-manager \
#  --version v0.12.0 \
#  --set ingressShim.defaultIssuerName=lets-encrypt-test \
#  --set ingressShim.defaultIssuerKind=Issuer \
#  --namespace ${CERT_MANAGER_NAMESPACE}

helm install cert-manager jetstack/cert-manager \
  --version v0.15.0 \
  --set ingressShim.defaultIssuerName=lets-encrypt-test \
  --set ingressShim.defaultIssuerKind=Issuer \
  --set installCRDs=true \
  --namespace ${CERT_MANAGER_NAMESPACE}

#bash ${COMMON}/footer.sh "CERT-MANAGER INSTALLED"
echo "===================================================== INSTALL CERT-MANAGER - OK"

exit 0