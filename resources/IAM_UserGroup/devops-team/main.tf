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
    key            = "devops-group/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}
 locals  {
    aws_region      = "us-east-2"
    Devops          = ["user1", "user2" , "user3" , "user4"]
    Dev             = ["name1" , "name2" , "name3" , "name4"]
    tags            =  {
    #Name            =  each.key 
    owner           = "danniella kitio"
    teams           = "DevOps"
    create_by       = "danniella"
    cloud_provider  = "aws"
    }
}

module "IAM_Users_Groups" {
    source          = "../../../modules/IAM_Users_Groups"
    aws_region      = local.aws_region   
    Devops          = local.Devops
    Dev         = local.Dev
    tags            = local.tags         
}