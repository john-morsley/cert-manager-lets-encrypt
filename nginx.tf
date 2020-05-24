resource "null_resource" "install-nginx" {

  depends_on = [
    module.multiple-node-cluster
  ]

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/install_nginx.sh"
    environment = {
      KUBERNETES_FOLDER = "${path.cwd}/k8s"
      KUBE_CONFIG       = "${path.cwd}/k8s/kube-config.yaml"
      NAMESPACE         = var.namespace
    }
  }

}

# Is Concourse ready...?
resource "null_resource" "is-nginx-ready" {

  depends_on = [
    null_resource.install-nginx
  ]

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "bash ${path.module}/${local.shared_scripts_folder}/kubernetes/are_deployments_ready.sh ${path.cwd}/k8s/kube-config.yaml ${var.namespace}"
  }

}