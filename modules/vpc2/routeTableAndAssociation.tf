# Route Table for Public Subnets
resource "aws_route_table" "public" {
  count  = length(aws_subnet.public)
  vpc_id = aws_vpc.group-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.igw.id
  }

  tags =  merge(var.tags, {
    Name = format("%s-%s-public-route", var.tags ["environment"], var.tags["project"])
  }
  )
}

# Associate Public Subnets with the Public Route Table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  count  = length(aws_subnet.private)
  vpc_id = aws_vpc.group-vpc.id

  tags =  merge(var.tags, {
    Name = format("%s-%s-private-rout-%d", var.tags["environment"], var.tags["project"], count.index + 1)
  }
  )
}

# Add Routes to NAT Gateways
resource "aws_route" "private" {
  count                  = length(aws_nat_gateway.nat)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = var.destination_cidr_block
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}

# Associate Private Subnets with the Private Route Table
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
