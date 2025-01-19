# instance_type          = "t2.small"
# region                 =  "us-east-2"
# key_name               = "jenkins-keypair"
# desired_capacity          = 1
# min_size                  = 1
# max_size                  = 5
# health_check_type         = "EC2"
# health_check_grace_period = 300
# ttl                       = 300
# scaleUp = {
#     scaling_adjustment     = "1"
#     adjustment_type        = "ChangeInCapacity"
#     cooldown               = "300"
# }
# scaleDown = {
#     scaling_adjustment     = "-1"
#     adjustment_type        = "ChangeInCapacity"
#     cooldown               = "300"
# }

# tags =  {
#   "owner"          = "danniella kitio"
#   "teams"          = "DevOps"
#   "environment"    = "prod"
#   "project"        = "doityourself"
#   "create_by"      = "danniella"
#   "cloud_provider" = "aws"
# }
