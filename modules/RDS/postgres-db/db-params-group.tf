resource "aws_db_parameter_group" "postgres_params" {
  name        = format("%s-%s-postgres16-custom-params", var.tags["environment"], var.tags["project"])
  family      = var.family              # PostgreSQL 16 parameter group family
  description = "Custom parameter group for PostgreSQL 16"
}
