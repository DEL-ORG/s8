data "aws_vpc" "my_vpc" {
  filter {
    name   = "tag:Name"
    values = [format("%s-%s-vpc", var.tags["environment"], var.tags["project"])]
  }
}

data "aws_subnet" "private_subnet" {
   count = lookup(var.subnet_count, var.tags.environment)

  filter {
    name   = "tag:Name"
    values = [format("%s-%s-private-subnet-%d", var.tags["environment"], var.tags["project"], count.index + 1)]
  }
}

data "aws_secretsmanager_secret" "my_db_password" {
  name        = format("%s-%s-DB_PASSWORD1", var.tags["environment"], var.tags["project"])
  }
data "aws_secretsmanager_secret_version" "my_db_password" {
  secret_id = data.aws_secretsmanager_secret.my_db_password.id
}

data "aws_secretsmanager_secret" "my_db_username" {
  name        = format("%s-%s-DB_USERNAME1", var.tags["environment"], var.tags["project"])
  }
data "aws_secretsmanager_secret_version" "my_db_username" {
  secret_id = data.aws_secretsmanager_secret.my_db_username.id
}

output "my_db_username_decoded" {
  value = jsondecode(data.aws_secretsmanager_secret_version.my_db_username.secret_string)
  sensitive = true
}

output "my_db_password_decoded" {
  value = jsondecode(data.aws_secretsmanager_secret_version.my_db_password.secret_string)
  sensitive = true
}