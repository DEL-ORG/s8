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
    key            = "dev-alb/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "danie-s3-bucket-lock"
  }
}

locals {
    region                     = "us-east-2"
    load_balancer_type         = "application"
    enable_deletion_protection = false
    internal                   = false 
    tags                        =  {
        "owner"          = "danniella kitio"
        "teams"          = "DevOps"
        "environment"    = "dev"
        "project"        = "doityourself"
        "create_by"      = "danniella"
        "cloud_provider" = "aws"
    }
    JenkinsTG             = {
        path                = "/login"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
        port                = 8080
        protocol            = "HTTP"
        target_type         = "instance"
        }
    SonarTG                 = {
        path                = "/login"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
        port        = 9000
        protocol    = "HTTP" 
        target_type = "instance"
    }
}

module "ApplicationLoadBalancer" {
  source = "../../../modules/applicationLoadBalancer"
  region                     = local.region                    
  load_balancer_type         = local.load_balancer_type        
  enable_deletion_protection = local.enable_deletion_protection
  internal                   = local.internal                  
  tags                       = local.tags    
  JenkinsTG                  = local.JenkinsTG   
  SonarTG                    = local.SonarTG               
}