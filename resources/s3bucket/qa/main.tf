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

locals {
   hash_key       = "LockID"
   read_capacity  = "20"
   write_capacity = "20"
   status         = "Enabled"
   name           = "LockID"
   region = "us-east-2"
   type           = "S"
   tags           =  {
     "id"             = "2560"
     "owner"          = "danniella kitio"
     "teams"          = "DevOps"
     "environment"    = "qa"
     "project"        = "doityourself"
     "create_by"      = "danniella"
     "cloud_provider" = "aws"
    } 
}
module "s3bucket" {
     source = "../../../modules/s3bucket"
     hash_key       =  local.hash_key       
     read_capacity  =  local.read_capacity  
     write_capacity =  local.write_capacity 
     status         =  local.status         
     name           =  local.name           
     type           =  local.type 
     region         = local.region          
     tags           =  local.tags           
}
