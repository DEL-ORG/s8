# Allocate Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
  count = var.tags.environment == "prod" ? length(aws_subnet.private) : 1
  vpc   = true

  tags = merge(var.tags, {
    Name = format("%s-%s-eip-%d", var.tags["environment"], var.tags["project"], count.index + 1)
  }
  )
}