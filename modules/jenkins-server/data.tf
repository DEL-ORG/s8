data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = [format("%s-%s-private-subnet-1", var.tags["environment"], var.tags["project"]),
    format("%s-%s-private-subnet-2", var.tags["environment"], var.tags["project"]),
    format("%s-%s-private-subnet-3", var.tags["environment"], var.tags["project"])]
  }
}

# data "aws_subnet" "private_subnet2" {
#   filter {
#     name   = "tag:Name"
#     values = [format("%s-%s-private-subnet-2", var.tags["environment"], var.tags["project"])]
#   }
# }

#ssh -i jenkins-keypair.pem ubuntu@10.20.101.154   cd ..

data "aws_vpc" "my_vpc" {
  filter {
    name   = "tag:Name"
    values = [format("%s-%s-vpc", var.tags["environment"], var.tags["project"])]
  }
}

output "aws_vpc_id" {
  value = data.aws_vpc.my_vpc.id
}

data "aws_security_group" "bastion-sg" {
  filter {
    name   = "tag:Name"
    values = [format("%s-%s-bastion-sg", var.tags["environment"], var.tags["project"])] 
  }
}

data "aws_security_group" "alb_sg"  {
  filter {
    name   = "tag:Name"
    values = [format("%s-ALB_SG", var.tags["environment"])]
  }
}  

data "aws_lb_target_group" "JenkinsTG"   {
    name = format("%s-JenkinsTG", var.tags["environment"])
  }


data "aws_lb" "ALB" {
    name = format("%s-ALB", var.tags["environment"])
  }
