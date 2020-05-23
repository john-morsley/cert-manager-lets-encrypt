#      _          _   _       ______                             _   
#     | |        | | ( )     |  ____|                           | |  
#     | |     ___| |_|/ ___  | |__   _ __   ___ _ __ _   _ _ __ | |_ 
#     | |    / _ \ __| / __| |  __| | '_ \ / __| '__| | | | '_ \| __|
#     | |___|  __/ |_  \__ \ | |____| | | | (__| |  | |_| | |_) | |_ 
#     |______\___|\__| |___/ |______|_| |_|\___|_|   \__, | .__/ \__|
#                                                     __/ | |        
#                                                    |___/|_|        

# Install Let's Encrypt...
resource "null_resource" "install-lets-encrypt" {

  depends_on = [
    null_resource.is-cert-manager-ready,
    null_resource.ingress
  ]

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/install_lets_encrypt.sh"
    environment = {
      KUBERNETES_FOLDER = "${path.cwd}/k8s"
      KUBE_CONFIG       = "${path.cwd}/k8s/kube-config.yaml"
      NAMESPACE         = var.namespace
    }
  }

}

# Is Let's Encrypt ready...?
//resource "null_resource" "is-lets-encrypt-ready" {
//
//  depends_on = [
//    null_resource.install-lets-encrypt
//  ]
//
//  # https://www.terraform.io/docs/provisioners/local-exec.html
//
//  provisioner "local-exec" {
//    command = "bash ${path.module}/scripts/is_lets_encrypt_ready.sh"
//    #environment = {
//      #FOLDER    = "${path.cwd}/${local.folder}"
//      #NAMESPACE = var.namespace
//    #}
//  }
//
//}
