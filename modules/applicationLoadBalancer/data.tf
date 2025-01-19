data "aws_subnets" "public_subnets" {
  filter {
    name   = "tag:Name"
    values = [format("%s-%s-public-subnet-1", var.tags["environment"], var.tags["project"]),
    format("%s-%s-public-subnet-2", var.tags["environment"], var.tags["project"]),
    format("%s-%s-public-subnet-3", var.tags["environment"], var.tags["project"])]
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

data "aws_secretsmanager_secret" "kendan_certificate" {
  name        = "KendanCertificate_arn"
  }
data "aws_secretsmanager_secret_version" "kendan_certificate" {
  secret_id = data.aws_secretsmanager_secret.kendan_certificate.id
}
