data "aws_subnet" "private_subnet" {
   count = lookup(var.subnet_count, var.tags.environment)

  filter {
    name   = "tag:Name"
    values = [format("%s-%s-private-subnet-%d", var.tags["environment"], var.tags["project"], count.index + 1)]
  }
}

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

data "aws_lb_target_group" "SonarTG"   {
    name = format("%s-SonarTG", var.tags["environment"])
  }


data "aws_lb" "ALB" {
    name = format("%s-ALB", var.tags["environment"])
  }
