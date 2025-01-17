# Define Subnets
resource "aws_subnet" "private" {
  count           = var.tags.environment == "prod" ? 3 : 2
  vpc_id          = aws_vpc.group-vpc.id
  cidr_block      = cidrsubnet(aws_vpc.group-vpc.cidr_block, 8, count.index + 1) 
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = merge(var.tags, {
    Name = format("%s-%s-private-subnet-%d", var.tags["environment"], var.tags["project"], count.index + 1)
  }
  )
}

resource "aws_subnet" "public" {
  count           = var.tags.environment == "prod" ? 3 : 2
  vpc_id          = aws_vpc.group-vpc.id
  cidr_block      = cidrsubnet(aws_vpc.group-vpc.cidr_block, 8, count.index + 10)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags =  merge(var.tags, {
    Name = format("%s-%s-public-subnet-%d", var.tags["environment"], var.tags["project"], count.index + 1)
  }
  )
}

# Data source to get available AZs
data "aws_availability_zones" "available" {}
