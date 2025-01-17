# region                     = "us-east-2"
# load_balancer_type         = "application"
# enable_deletion_protection = false
# internal                   = false 
# tags                        =  {
#   "owner"          = "danniella kitio"
#   "teams"          = "DevOps"
#   "environment"    = "dev"
#   "project"        = "doityourself"
#   "create_by"      = "danniella"
#   "cloud_provider" = "aws"
# }

# JenkinsTG             = {
#     path                = "/login"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     port                = 8080
#     protocol            = "HTTP"
#     target_type         = "instance"
# }

# SonarTG               = {
#   path                = "/login"
#   interval            = 30
#   timeout             = 5
#   healthy_threshold   = 2
#   unhealthy_threshold = 2
#   port        = 9000
#   protocol    = "HTTP" 
#   target_type = "instance"
# }
