#      _____                               
#     |_   _|                              
#       | |  _ __   __ _ _ __ ___  ___ ___ 
#       | | | '_ \ / _` | '__/ _ \/ __/ __|
#      _| |_| | | | (_| | | |  __/\__ \__ \
#     |_____|_| |_|\__, |_|  \___||___/___/
#                   __/ |                  
#                  |___/                   

resource "null_resource" "ingress" {

  depends_on = [
    module.multiple-node-cluster,
    null_resource.is-nginx-ready
  ]

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/ingress.sh"
    environment = {
      KUBERNETES_FOLDER = "${path.cwd}/k8s"
      KUBE_CONFIG       = "${path.cwd}/k8s/kube-config.yaml"
      NAMESPACE         = var.namespace
    }
  }

}