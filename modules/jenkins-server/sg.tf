resource "aws_security_group" "jenkinsSG" {
  name        = format("%s-%s-jenkinServer-sg", var.tags["environment"], var.tags["project"])
  vpc_id      =  data.aws_vpc.my_vpc.id 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [data.aws_security_group.bastion-sg.id]  # allow traffic only from the bastionHost
  }

   ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [data.aws_security_group.alb_sg.id]  # allow traffic only from ALB
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = format("%s-%s-jenkinsSG", var.tags["environment"], var.tags["project"]) 
  }
  )
}