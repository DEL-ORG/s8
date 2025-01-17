resource "aws_db_subnet_group" "main" {
  name       = format("%s-%s-subnet-group", var.tags["environment"], var.tags["project"])
  
  # Fetch all subnets dynamically to meet the AZ coverage requirement
  subnet_ids = data.aws_subnet.private_subnet[*].id

  tags = {
    Name = format("%s-%s-main-subnet-group", var.tags["environment"], var.tags["project"])
  }
}
