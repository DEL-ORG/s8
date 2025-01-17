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
  region = local.region
}

terraform {
  backend "s3" {
    bucket         = "danie-s3-bucket"
    key            = "vpc1-resource/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}

locals {
    region = "us-east-2"
    cidr_block = "10.0.0.0/16"
    cluster_name = "danie-dev-eks"
    tags =  {
        "id"             = "2525"
        "owner"          = "danniella kitio"
        "teams"          = "DevOps"
        "environment"    = "production"
        "project"        = "doityourself"
        "create_by"      = "danniella"
        "cloud_provider" = "aws"
    }

    public_subnets_cidr_block = [
       "10.0.1.0/24",
       "10.0.2.0/24", 
       "10.0.3.0/24",
    ]

    private_subnets_cidr_block = [
      "10.0.101.0/24",
      "10.0.102.0/24", 
      "10.0.103.0/24",
      "10.0.104.0/24",
      "10.0.105.0/24",
      "10.0.106.0/24"
    ]
    
    availability_zone = [
      "us-east-2a",
      "us-east-2b",
      "us-east-2c"
    ]
}

module "vpc" {
    source = "../../../modules/vpc"
    region                      = local.region                    
    cidr_block                  = local.cidr_block                
    tags                        = local.tags                      
    public_subnets_cidr_block   = local.public_subnets_cidr_block 
    private_subnets_cidr_block  = local.private_subnets_cidr_block
    availability_zone           = local.availability_zone  
    cluster_name                = local.cluster_name       
}
