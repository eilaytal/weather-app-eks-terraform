terraform {
  backend "s3" {
    bucket         = "weatherapp-eks-state-backend-1"
    key            = "terraform.tfstate"
    region         = "il-central-1"
    dynamodb_table = "WeatherApp-Eks-state-backend-1"
    skip_region_validation = true
  }
}


provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = var.vpc_name
  region = var.aws_region

  vpc_cidr = var.vpc_cidr
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=25322b6b6be69db6cca7f167d7b0e5327156a595"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  
  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
  "kubernetes.io/role/elb" = "1"
}
private_subnet_tags = {
  "kubernetes.io/role/internal-elb" = "1"
}

  tags = local.tags
}




# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "19.15.1"

#   cluster_name                   = local.name
#   cluster_endpoint_public_access = true

#   cluster_addons = {
#     coredns = {
#       most_recent = true
#     }
#     kube-proxy = {
#       most_recent = true
#     }
#     vpc-cni = {
#       most_recent = true
#     }
#   }

#   vpc_id                   = module.vpc.vpc_id
#   subnet_ids               = module.vpc.private_subnets
#   control_plane_subnet_ids = module.vpc.intra_subnets

#   # EKS Managed Node Group(s)
#   eks_managed_node_group_defaults = {
#     ami_type       = "AL2_x86_64"
#     instance_types = ["m5.large"]

#     attach_cluster_primary_security_group = true
#   }

#   eks_managed_node_groups = {
#     ascode-cluster-wg = {
#       min_size     = 1
#       max_size     = 2
#       desired_size = 1

#       instance_types = ["t3.large"]
#       capacity_type  = "SPOT"

#       tags = {
#         ExtraTag = "helloworld"
#       }
#     }
#   }

#   tags = local.tags
# }

