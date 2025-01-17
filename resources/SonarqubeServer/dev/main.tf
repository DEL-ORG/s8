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
    key            = "dev-SonarServer/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}
 locals  {
    ami                    = "ami-0af542376668f6eca"
    instance_type          = "t2.xlarge"
    region                 =  "us-east-2"
    key_name               = "jenkins-keypair" 
    tags =  {
      "owner"          = "danniella kitio"
      "teams"          = "DevOps"
      "environment"    = "dev"
      "project"        = "doityourself"
      "create_by"      = "danniella"
      "cloud_provider" = "aws"
    }
}

module "bastion_host" {
    source        = "../../../modules/sonaqube-server"
    ami           = local.ami           
    instance_type = local.instance_type 
    region        = local.region        
    key_name      = local.key_name      
    tags          = local.tags 
}