######## VPC #######
locals {
  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  public_subnets  = ["10.0.48.0/24", "10.0.49.0/24", "10.0.50.0/24"]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>6.6"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  #single NAT gateway to keep one-per-AZ for production
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

######## EKS Cluster #######

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 21.25"

#   name               = var.cluster_name
#   kubernetes_version = var.kubernetes_version

#   #public endpoin so kubectl works from a laptop Restrict or diasable for production
#   endpoint_public_access = true

#   #Grant identity running terraform cluster-admin via an EKS access entry
#   enable_cluster_creator_admin_permissions = true

#   vpc_id     = module.vpc.vpc_id
#   subnet_ids = module.vpc.private_subnets

#   #before_computer = true install these before node group is created
#   addons = {
#     eks-pod-identity-agent = {
#       before_computer = true
#     }

#     kube-proxy = {
#       before_computer = true
#     }

#     vpc-cni = {
#       before_computer = true
#     }
#   }

#   eks_managed_node_groups = {
#     default = {
#       kubernetes_version = var.kubernetes_version
#       ami_type           = "AL2023_x86_64_STANDARD"
#       instance_types     = var.instance_types

#       min_size     = 1
#       max_size     = 3
#       desired_size = var.desired_size
#     }
#   }
# }
