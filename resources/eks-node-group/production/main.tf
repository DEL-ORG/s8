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
    key            = "nodes-groupe/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}

locals {
  aws_region             = "us-east-2"
  eks_version            = "1.28"
  key_name               = "jenkins-keypair"
  desired_size           = "1"
  max_size               = "5"
  min_size               = "1"
  ami_type               = "AL2_x86_64"
  capacity_type          = "ON_DEMAND"
  disk_size              = 20
  force_update_version   = false
  instance_types         = ["t3.medium"]
  node_label             = "production"
  tags = {
    "id"             = "2560"
    "owner"          = "danniella kitio"
    "teams"          = "DevOps"
    "environment"    = "production"
    "project"        = "doityourself" 
    "create_by"      = "danniella"
    "cloud_provider" = "aws"
  }
}

module "eks-control-plane" {
  source = "../../../modules/eks-node-group"
  aws_region           =   local.aws_region           
  eks_version          =   local.eks_version         
  key_name             =   local.key_name            
  desired_size         =   local.desired_size        
  max_size             =   local.max_size            
  min_size             =   local.min_size            
  ami_type             =   local.ami_type            
  capacity_type        =   local.capacity_type       
  disk_size            =   local.disk_size           
  force_update_version =   local.force_update_version
  instance_types       =   local.instance_types      
  node_label           =   local.node_label          
  tags                 =   local.tags                
} 