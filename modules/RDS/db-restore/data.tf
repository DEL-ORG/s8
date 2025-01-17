data "aws_vpc" "my_vpc" {
  filter {
    name   = "tag:Name"
    values = ["production-do-it-yourself-vpc"]
  }
}

output "aws_vpc" {
  value = data.aws_vpc.my_vpc.id
}

data "aws_subnet" "my_private_subnet1" {
  filter {
    name   = "tag:Name"
    values = ["production-do-it-yourself-private-subnet1"]
  }
}
output "aws_private_subnet1" {
  value = data.aws_subnet.my_private_subnet1.id
}

data "aws_subnet" "my_private_subnet2" {
  filter {
    name   = "tag:Name"
    values = ["production-do-it-yourself-private-subnet2"]
  }
}
output "aws_private_subnet2" {
  value = data.aws_subnet.my_private_subnet2.id
}

data "aws_subnet" "my_private_subnet3" {
  filter {
    name   = "tag:Name"
    values = ["production-do-it-yourself-private-subnet3"]
  }
}
output "aws_private_subnet3" {
  value = data.aws_subnet.my_private_subnet3.id
}

data "aws_subnet" "my_private_subnet4" {
  filter {
    name   = "tag:Name"
    values = ["production-do-it-yourself-private-subnet4"]
  }
}
output "aws_private_subnet4" {
  value = data.aws_subnet.my_private_subnet4.id
}

data "aws_subnet" "my_private_subnet5" {
  filter {
    name   = "tag:Name"
    values = ["production-do-it-yourself-private-subnet5"]
  }
}
output "aws_private_subnet5" {
  value = data.aws_subnet.my_private_subnet5.id
}

data "aws_subnet" "my_private_subnet6" {
  filter {
    name   = "tag:Name"
    values = ["production-do-it-yourself-private-subnet6"]
  }
}
output "aws_private_subnet6" {
  value = data.aws_subnet.my_private_subnet6.id
}

data "aws_secretsmanager_secret" "my_db_password" {
  name        = format("%s-%s-db-password1", var.tags["environment"], var.tags["project"])
  }
data "aws_secretsmanager_secret_version" "my_db_password" {
  secret_id = data.aws_secretsmanager_secret.my_db_password.id
}

data "aws_secretsmanager_secret" "my_db_username" {
  name        = format("%s-%s-db-username", var.tags["environment"], var.tags["project"])
  }
data "aws_secretsmanager_secret_version" "my_db_username" {
  secret_id = data.aws_secretsmanager_secret.my_db_username.id
}

## This is to restore from snapshot
data "aws_db_snapshot" "example_snapshot" {
  # db_snapshot_identifier = format("%sArtifactorySnapshot", var.common_tags["Project"])
  db_snapshot_identifier = "alphaartifactorysnapshot"
}
