#     __      __        _       _     _           
#     \ \    / /       (_)     | |   | |          
#      \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___ 
#       \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
#        \  / (_| | |  | | (_| | |_) | |  __/\__ \
#         \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/

# AWS

variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

variable "region" {
  type = string
  default = "eu-west-2" # London
}

# VPC

variable "vpc_name" {
  type = string
  default = "cert-manager-lets-encrypt"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24"]
}

# IAM Role

variable "iam_role_name" {
  type = string
  default = "cert-manager-lets-encrypt"
}

# EC2 (Node)

variable "ec2_name" {
  type = string
  default = "node"
}

variable "ec2_instance_type" {
  type = string
  default = "t2.xlarge"
}

# Cluster

variable "cluster_name" {
  type = string
  default = "cert-manager-lets-encrypt"
}

# Project

variable "namespace" {
  default = "cert-manager-lets-encrypt"
}

# Domain

variable "domain" {
  default = "morsley.io"
}

variable "sub_domain" {
  default = "cert-manager-lets-encrypt"
}

# Cert-Manager

variable "cert_manager_namespace" {
  default = "cert-manager"
}