#       _____          _   _  __ _           _       
#      / ____|        | | (_)/ _(_)         | |      
#     | |     ___ _ __| |_ _| |_ _  ___ __ _| |_ ___ 
#     | |    / _ \ '__| __| |  _| |/ __/ _` | __/ _ \
#     | |___|  __/ |  | |_| | | | | (_| (_| | ||  __/
#      \_____\___|_|   \__|_|_| |_|\___\__,_|\__\___|
#           __  __                                   
#          |  \/  |                                  
#          | \  / | __ _ _ __   __ _  __ _  ___ _ __ 
#          | |\/| |/ _` | '_ \ / _` |/ _` |/ _ \ '__|
#          | |  | | (_| | | | | (_| | (_| |  __/ |   
#          |_|  |_|\__,_|_| |_|\__,_|\__, |\___|_|   
#                                     __/ |          
#                                    |___/           

# Install Cert-Manager...
resource "null_resource" "install-cert-manager" {

  depends_on = [
    module.multiple-node-cluster,
    null_resource.ingress
  ]

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/install_cert_manager.sh"
    environment = {
      KUBERNETES_FOLDER      = "${path.cwd}/k8s"
      KUBE_CONFIG            = "${path.cwd}/k8s/kube-config.yaml"
      CERT_MANAGER_NAMESPACE = var.cert_manager_namespace
    }
  }

}

# Is Cert-Manager ready...?
resource "null_resource" "is-cert-manager-ready" {

  depends_on = [
    null_resource.get-shared-scripts,
    null_resource.install-cert-manager
  ]

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "bash ${path.module}/${local.shared_scripts_folder}/kubernetes/are_deployments_ready.sh '${path.cwd}/k8s/kube-config.yaml' '${var.cert_manager_namespace}'"
  }

}