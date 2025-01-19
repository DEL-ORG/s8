terraform {
  required_version = ">= 1.0.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket         = "danie-s3-bucket"
    key            = "kendan-acm/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}

locals {
    region                    = "us-east-2"
    subject_alternative_names = "*.kendanbeauty.com"
    domain_name               = "kendanbeauty.com"
    ttl                       = 60
    tags                        =  {
    "owner"          = "danniella kitio"
    "teams"          = "DevOps"
    "environment"    = "prod"
    "project"        = "doityourself"
    "create_by"      = "danniella"
    "cloud_provider" = "aws"
    "compagny"       = "kendan"
    }
}

module "acm" {
    source = "../../modules/acm"
    region                     = local.region                   
    subject_alternative_names  = local.subject_alternative_names
    domain_name                = local.domain_name  
    ttl                        = local.ttl            
    tags                       = local.tags  
}                   