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
    key            = "blue-green-nodes-groupe/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}

locals {
aws_region                = "us-east-2"
cluster_name              = "production-doityourself-eks"
eks_version               = "1.28"
node_min                  = "2"
desired_node              = "2"
node_max                  = "6"
blue_node_color           = "blue"
green_node_color          = "green"
blue                      = false
green                     = true
ec2_ssh_key               = "jenkins-keypair"
deployment_nodegroup      = "blue_green"
capacity_type             = "ON_DEMAND"
ami_type                  = "AL2_x86_64"
instance_types            = "t3.medium"
disk_size                 = "10"
shared_owned              = "shared"
enable_cluster_autoscaler = "true"
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

module "eks-blue-green-node-group" {
source = "../../../modules/eks-blue-green-node-group"
aws_region                = local.aws_region               
cluster_name              = local.cluster_name             
eks_version               = local.eks_version              
node_min                  = local.node_min                 
desired_node              = local.desired_node             
node_max                  = local.node_max                 
blue_node_color           = local.blue_node_color          
green_node_color          = local.green_node_color         
blue                      = local.blue                     
green                     = local.green                    
ec2_ssh_key               = local.ec2_ssh_key              
deployment_nodegroup      = local.deployment_nodegroup     
capacity_type             = local.capacity_type            
ami_type                  = local.ami_type                 
instance_types            = local.instance_types           
disk_size                 = local.disk_size                
shared_owned              = local.shared_owned             
enable_cluster_autoscaler = local.enable_cluster_autoscaler         
tags                      = local.tags                
} 