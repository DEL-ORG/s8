terraform {
  required_version = ">= 1.0.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = local.aws_region
}

terraform {
  backend "s3" {
    bucket         = "danie-s3-bucket"
    key            = "eks-control-plane/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}



locals {
  aws_region = "us-east-2"
  cluster_name = "production-doityourself-eks"
  eks_version = "1.28"
  endpoint_public_access = true
  endpoint_private_access = false
  tags = {
    "id"             = "2525"
    "owner"          = "danniella kitio"
    "teams"          = "DevOps"
    "environment"    = "production"
    "project"        = "doityourself"
    "create_by"      = "danniella"
    "cloud_provider" = "aws"
  }


}

module "eksControlPlane" {
  source                  = "../../../modules/eks-control-plane"
  aws_region              = local.aws_region
  eks_version             = local.eks_version
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  tags                    = local.tags
  cluster_name            = local.cluster_name
}


