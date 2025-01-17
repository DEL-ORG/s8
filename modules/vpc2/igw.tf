resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.group-vpc.id

  tags =  merge(var.tags, { 
    Name = format("%s-%s-igw", var.tags ["environment"], var.tags["project"])
  }
  )
}