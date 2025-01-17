resource "aws_db_instance" "postgres" {
  allocated_storage           = lookup(var.PostgreSQL, "allocated_storage")  # Initial storage size in GB
  max_allocated_storage       = lookup(var.PostgreSQL, "max_allocated_storage")    # Maximum storage size in GB
  engine                      = lookup(var.PostgreSQL, "engine")
  engine_version              = lookup(var.PostgreSQL, "engine_version")# or any other desired version
  instance_class              = lookup(var.PostgreSQL, "instance_class")   # Choose based on your needs
  db_name                     = format("%s%sdaniepgdb", var.tags["environment"], var.tags["project"])   # Database name
  username                    = danniella #data.aws_secretsmanager_secret_version.my_db_username.secret_string       # Master username
  password                    = data.aws_secretsmanager_secret_version.my_db_password.secret_string       # Master password 
  skip_final_snapshot         = lookup(var.PostgreSQL, "skip_final_snapshot" )       # Don't snapshot on deletion
  publicly_accessible         = lookup(var.PostgreSQL, "publicly_accessible" )       # False for security; you can change this
  auto_minor_version_upgrade  = lookup(var.PostgreSQL, "auto_minor_version_upgrade" )
  allow_major_version_upgrade = lookup(var.PostgreSQL, "allow_major_version_upgrade" )
  multi_az                    = lookup(var.PostgreSQL, "multi_az" )
  backup_retention_period     = lookup(var.PostgreSQL, "backup_retention_period" )         # number of the snapshot will e keep before automate deletion
  deletion_protection         = lookup(var.PostgreSQL, "deletion_protection" )         # if true we can't delte the db, we will need to set it to false to delete it.
  ##maintenance_window        = lookup(var.PostgreSQL, )         # Define a maintenance window (e.g., every Wednesday 1 AM to 2 AM UTC)
  identifier                  = format("%s-%s-prod-pg-db", var.tags["environment"], var.tags["project"]) 
  parameter_group_name       = aws_db_parameter_group.postgres_params.name 

  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name  # Parameter group
  snapshot_identifier = data.aws_db_snapshot.example_snapshot.id
  tags = {
    Name = format("%s-%s-postgres-sg", var.tags["environment"], var.tags["project"])
  }
}




