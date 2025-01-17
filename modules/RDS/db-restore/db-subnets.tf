resource "aws_db_subnet_group" "main" {
  name       = format("%s-%s-subnet-group", var.tags["environment"], var.tags["project"])
  subnet_ids = [ data.aws_subnet.my_private_subnet1.id, 
                data.aws_subnet.my_private_subnet2.id, 
                data.aws_subnet.my_private_subnet3.id, 
                data.aws_subnet.my_private_subnet4.id, 
                data.aws_subnet.my_private_subnet5.id, 
                data.aws_subnet.my_private_subnet6.id ]

  tags = {
    Name = format("%s-%s-main-subnet-group", var.tags["environment"], var.tags["project"])
  }
}