#  aws_region = "us-east-2"
#  secret_names = [format("%s-%s-DB_USERNAME", var.tags["environment"], var.tags["project"]) , format("%s-%s-DB_PASSWORD", var.tags["environment"], var.tags["project"])]
#  tags =  {
#    Name            =  each.key 
#    owner           = "danniella kitio"
#    teams           = "DevOps"
#    environment     = "production"
#    project         = "doityourself"
#    create_by       = "danniella"
#    cloud_provider  = "aws"
#  }
