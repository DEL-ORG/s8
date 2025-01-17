resource "aws_nat_gateway" "nat" {
  count         = var.tags.environment == "prod" ?  length(aws_subnet.private) : 1
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(aws_subnet.public[*].id, count.index)

  tags =  merge(var.tags, {
    Name = format("%s-%s-nat-%d", var.tags["environment"], var.tags["project"], count.index + 1)
  }
  )
}
