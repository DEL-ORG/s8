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
  region = local.aws_region
}

terraform {
  backend "s3" {
    bucket         = "danie-s3-bucket"
    key            = "prod-postgressDB/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}

locals {
  aws_region = "us-east-2"
  family     = "postgres16"  
  tags =  {
    "owner"          = "danniella kitio"
    "teams"          = "DevOps"
    "environment"    = "prod"
    "project"        = "doityourself"
    "create_by"      = "danniella"
    "cloud_provider" = "aws"
  }
  PostgreSQL = {
    allocated_storage            =  10            
    max_allocated_storage        =  100           
    engine                       =  "postgres"
    engine_version               =  "16.3"        
    instance_class               =  "db.t3.micro" 
    skip_final_snapshot          =  true                    
    auto_minor_version_upgrade   =  true
    allow_major_version_upgrade  =  false
    multi_az                     =  true
    backup_retention_period      =   7    
    deletion_protection          =   false 
    ##maintenance_window         =  "wed:01:00-wed:02:00" 
    publicly_accessible         = false
  }
}
module "PostgreSQL" {
    source = "../../../../modules/RDS/postgres-db"
    aws_region   =  local.aws_region   
    family       =  local.family        
    tags         =  local.tags        
    PostgreSQL   =  local.PostgreSQL  
}