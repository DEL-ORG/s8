resource "aws_security_group" "SonarServerSG" {
  name        = format("%s-%s-SonarSG", var.tags["environment"], var.tags["project"])
  vpc_id      =  data.aws_vpc.my_vpc.id 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [data.aws_security_group.bastion-sg.id]  # allow traffic only from the bastionHost
  }

   ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #security_groups = [data.aws_security_group.alb_sg.id]  # allow traffic only from ALB
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = format("%s-%s-SonarSG", var.tags["environment"], var.tags["project"]) 
  }
  )
}