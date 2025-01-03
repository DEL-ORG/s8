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
    key            = "prod-secret_manager/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}
 locals  {
    aws_region      = "us-east-2"
    secret_names    = [format("%s-%s-DB_USERNAME", local.tags["environment"], local.tags["project"]) , format("%s-%s-DB_PASSWORD", local.tags["environment"], local.tags["project"])]
    tags            =  {
      # Name            =  each.key 
      owner           = "danniella kitio"
      teams           = "DevOps"
      environment     = "qa"
      project         = "doityourself"
      create_by       = "danniella"
      cloud_provider  = "aws"
      }
}

module "secret-manager" {
    source        = "../../modules/secret-manager"
    aws_region      = local.aws_region   
    secret_names    = local.secret_names 
    tags            = local.tags         
}
