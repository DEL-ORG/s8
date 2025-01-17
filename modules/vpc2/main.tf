resource "aws_vpc" "group-vpc" {
  cidr_block           = var.cidr_block
  tags = merge(var.tags, {
    Name = format("%s-%s-vpc", var.tags ["environment"], var.tags["project"])
  }
  )
}


