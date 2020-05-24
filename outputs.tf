#     ____        _               _       
#    / __ \      | |             | |      
#   | |  | |_   _| |_ _ __  _   _| |_ ___ 
#   | |  | | | | | __| '_ \| | | | __/ __|
#   | |__| | |_| | |_| |_) | |_| | |_\__ \
#    \____/ \__,_|\__| .__/ \__,_|\__|___/
#                    | |                  
#                    |_|

output "private_ip_node_1" {
  value = module.node-1-ec2.private_ip
}

output "public_ip_node_1" {
  value = module.node-1-ec2.public_ip
}

output "public_dns_node_1" {
  value = module.node-1-ec2.public_dns
}

output "ssh_command_node_1" {
  value = module.node-1-ec2.ssh_command
}

output "export_kubeconfig_command" {
  value = module.multiple-node-cluster.export_kubeconfig_command
}

output "kubectl_kubeconfig_command" {
  value = module.multiple-node-cluster.kubectl_kubeconfig_command
}

output "bucket_name" {
  value = local.bucket_name
}

output "vpc_id" {
  value = module.vpc.id
}

output "vpc_public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "vpc_private_subnets" {
  value = module.vpc.private_subnet_ids
}

output "vpc_public_subnet_1" {
  value = module.vpc.public_subnet_ids[0]
}