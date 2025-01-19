#  aws_region = "us-east-2"
#  secret_names = [format("%s-%s-dbUsername", var.tags["environment"], var.tags["project"]) , 
 #                  format("%s-%s-dbPassword", var.tags["environment"], var.tags["project"]),
 #                  "KendanCertificate_arn"]
#  tags =  {
#    Name            =  each.key 
#    owner           = "danniella kitio"
#    teams           = "DevOps"
#    environment     = "production"
#    project         = "doityourself"
#    create_by       = "danniella"
#    cloud_provider  = "aws"
#  }
