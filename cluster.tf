#       _____ _           _            
#      / ____| |         | |           
#     | |    | |_   _ ___| |_ ___ _ __ 
#     | |    | | | | / __| __/ _ \ '__|
#     | |____| | |_| \__ \ ||  __/ |   
#      \_____|_|\__,_|___/\__\___|_|   

module "multiple-node-cluster" {

  source = "john-morsley/kubernetes-cluster/aws"

  cluster_name = var.cluster_name 
  
  bucket_name = local.bucket_name
  
  ec2_data = [
    {
      user = "ubuntu"
      role = ["controlplane", "etcd", "worker"]
      public_ip = module.node-1-ec2.public_ip
      private_ip = module.node-1-ec2.private_ip
      encoded_private_key = module.node-1-ec2.encoded_private_key
    }
  ]

  mock_depends_on = [
    module.vpc,
    module.allow-all-sg,
    module.node-1-ec2
  ]
  
}