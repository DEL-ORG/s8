data "aws_subnet" "pubic_subnet" {
   count = lookup(var.subnet_count, var.tags.environment)

  filter {
    name   = "tag:Name"
    values = [format("%s-%s-public-subnet-%d", var.tags["environment"], var.tags["project"], count.index + 1)]
  }
}

#ssh -i jenkins-keypair.pem ubuntu@10.20.101.154   cd ..

data "aws_vpc" "my_vpc" {
  filter {
    name   = "tag:Name"
    values = [format("%s-%s-vpc", var.tags["environment"], var.tags["project"])]
  }
}

output "aws_vpc_id" {
  value = data.aws_vpc.my_vpc.id
}
