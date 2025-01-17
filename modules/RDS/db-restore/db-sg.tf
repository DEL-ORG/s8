resource "aws_security_group" "db_sg" {
  name   = format("%s-%s-postgresSG", var.tags["environment"], var.tags["project"])
  vpc_id = data.aws_vpc.my_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]  # Change to your IP range for access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-%s-postgresSG", var.tags["environment"], var.tags["project"])
  }
}
