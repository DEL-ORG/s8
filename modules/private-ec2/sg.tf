resource "aws_security_group" "private-ec2" {
  name        = format("%s-%s-private-ec2", var.tags["environment"], var.tags["project"])
  vpc_id      =  data.aws_vpc.my_vpc.id 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    security_groups = [data.aws_instance.bastion_host.id]  # allow traffic only from the bastionHost
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}