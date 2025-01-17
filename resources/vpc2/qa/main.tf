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
    key            = "qa-vpc2/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}

locals {
  region                 = "us-east-2"
  cidr_block             = "10.0.0.0/16"
  destination_cidr_block = "0.0.0.0/0"
  tags = {
    "owner"              = "danniella kitio"
    "teams"              = "DevOps"
    "environment"        = "qa"
    "project"            = "doityourself"
    "create_by"          = "danniella"
    "cloud_provider"     = "aws"
    }
}

module "vpc2" {
    source = "../../../modules/vpc2"
    region                 =  local.region                  
    cidr_block             =  local.cidr_block             
    destination_cidr_block =  local.destination_cidr_block
    tags                   =  local.tags               
}

