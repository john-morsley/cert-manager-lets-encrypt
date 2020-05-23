#!/usr/bin/env bash

#    _          _   _       ______                             _   
#   | |        | | ( )     |  ____|                           | |  
#   | |     ___| |_|/ ___  | |__   _ __   ___ _ __ _   _ _ __ | |_ 
#   | |    / _ \ __| / __| |  __| | '_ \ / __| '__| | | | '_ \| __|
#   | |___|  __/ |_  \__ \ | |____| | | | (__| |  | |_| | |_) | |_ 
#   |______\___|\__| |___/ |______|_| |_|\___|_|   \__, | .__/ \__|
#                                                   __/ | |        
#                                                  |___/|_|        

# GENERATE SSL/TLS CERTIFICATES WITH LET'S ENCRYPT.

#COMMON=$(pwd)/../common-kubernetes/scripts

#bash ${COMMON}/header.sh "SETTING UP LET'S ENCRYPT"
echo "====================================================== SETTING UP LET'S ENCRYPT"

#bash ${COMMON}/print_divider.sh

if [[ -z "${KUBERNETES_FOLDER}" ]]; then   
    echo "No KUBERNETES_FOLDER supplied."
    exit 666
fi
echo "KUBERNETES_FOLDER:" ${KUBERNETES_FOLDER}

if [[ -z "${KUBE_CONFIG}" ]]; then   
    echo "No KUBE_CONFIG supplied."
    exit 666
fi
echo "KUBE_CONFIG:" ${KUBE_CONFIG}

if [[ -z "${NAMESPACE}" ]]; then   
    echo "No NAMESPACE supplied."
    exit 666
fi
echo "NAMESPACE:" ${NAMESPACE}

#echo "pwd: " $(pwd)

#bash ${COMMON}/print_divider.sh

export KUBECONFIG=${KUBE_CONFIG}

# https://cert-manager.readthedocs.io/en/latest/reference/issuers.html

kubectl apply --filename ${KUBERNETES_FOLDER}/lets-encrypt-issuer.yaml \
              --namespace ${NAMESPACE}

# To check if this has worked:
# kubectl get issuers --namespace ${NAMESPACE}
# kubectl describe issuer [ISSUER NAME] --namespace ${NAMESPACE}

# https://cert-manager.readthedocs.io/en/latest/reference/issuers.html

kubectl apply --filename ${KUBERNETES_FOLDER}/lets-encrypt-certificate.yaml \
              --namespace ${NAMESPACE}

# To check if this has worked:
# kubectl get certificates --namespace ${NAMESPACE}
# kubectl describe certificate [CERTIFICATE NAME] --namespace ${NAMESPACE}

# Also, check the 'Ingress'. It should have another path added to it.
# kubectl get ingresses --namespace ${NAMESPACE}
# kubectl describe ingress [INGRESS NAME] --namespace ${NAMESPACE}

# https://whynopadlock.com
# https://www.ssllabs.com/ssltest/

#bash ${COMMON}/footer.sh "LET'S ENCRYPT HAS BEEN SET UP"
echo "================================================= SETTING UP LET'S ENCRYPT - OK"