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
    instance_type          = "t2.xlarge"
    region                 =  "us-east-2"
    key_name               = "jenkins-keypair" 
    desired_capacity          = 1
    min_size                  = 1
    max_size                  = 5
    health_check_type         = "EC2"
    health_check_grace_period = 300
    ttl                       = 300
    scaleUp = {
        scaling_adjustment     = "1"
        adjustment_type        = "ChangeInCapacity"
        cooldown               = "300"
    }
    scaleDown = {
        scaling_adjustment     = "-1"
        adjustment_type        = "ChangeInCapacity"
        cooldown               = "300"
    }
    tags =  {
      "owner"          = "danniella kitio"
      "teams"          = "DevOps"
      "environment"    = "dev"
      "project"        = "doityourself"
      "create_by"      = "danniella"
      "cloud_provider" = "aws"
    }
}

module "sonarqube" {
    source        = "../../../modules/sonaqube-server"        
    instance_type = local.instance_type 
    region        = local.region        
    key_name      = local.key_name  
    desired_capacity          = local.desired_capacity         
    min_size                  = local.min_size                 
    max_size                  = local.max_size                 
    health_check_type         = local.health_check_type        
    health_check_grace_period = local.health_check_grace_period
    ttl                       = local.ttl
    scaleUp                   = local.scaleUp
    scaleDown                 = local.scaleDown  
    tags          = local.tags 
}