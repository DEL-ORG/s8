resource "aws_secretsmanager_secret" "my_db_username" {
   for_each = toset(var.secret_names)
   name        =  each.key
}
