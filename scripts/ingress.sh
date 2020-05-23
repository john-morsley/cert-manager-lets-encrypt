#!/usr/bin/env bash

#    _____                               
#   |_   _|                              
#     | |  _ __   __ _ _ __ ___  ___ ___ 
#     | | | '_ \ / _` | '__/ _ \/ __/ __|
#    _| |_| | | | (_| | | |  __/\__ \__ \
#   |_____|_| |_|\__, |_|  \___||___/___/
#                __/ |                  
#               |___/                   

echo "================================================================ ADDING INGRESS"

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

echo "-------------------------------------------------------------------------------"
                                        
export KUBECONFIG=${KUBE_CONFIG}

kubectl apply --filename ${KUBERNETES_FOLDER}/ingress.yaml \
              --namespace ${NAMESPACE}

echo "============================================================ INGRESS ADDED - OK"

exit 0