resource "aws_db_instance" "postgres" {
  allocated_storage           = lookup(var.PostgreSQL, "allocated_storage")  
  max_allocated_storage       = lookup(var.PostgreSQL, "max_allocated_storage")    
  engine                      = lookup(var.PostgreSQL, "engine")
  engine_version              = lookup(var.PostgreSQL, "engine_version")
  instance_class              = lookup(var.PostgreSQL, "instance_class")  
  db_name                     = format("%s-%sdaniepgdb", var.tags["environment"], var.tags["project"])   # Database name
  username                    = jsondecode(data.aws_secretsmanager_secret_version.my_db_username.secret_string)["DB_USERNAME"]      # Master username
  password                    = jsondecode(data.aws_secretsmanager_secret_version.my_db_password.secret_string)["DB_PASSWORD"]       # Master password 
  skip_final_snapshot         = lookup(var.PostgreSQL, "skip_final_snapshot" )       # Don't snapshot on deletion
  publicly_accessible         = lookup(var.PostgreSQL, "publicly_accessible" )       # False for security; you can change this
  auto_minor_version_upgrade  = lookup(var.PostgreSQL, "auto_minor_version_upgrade" )
  allow_major_version_upgrade = lookup(var.PostgreSQL, "allow_major_version_upgrade" )
  multi_az                    = lookup(var.PostgreSQL, "multi_az" )
  backup_retention_period     = lookup(var.PostgreSQL, "backup_retention_period" )        
  deletion_protection         = lookup(var.PostgreSQL, "deletion_protection" )       
  ##maintenance_window        = lookup(var.PostgreSQL, )         # Define a maintenance window (e.g., every Wednesday 1 AM to 2 AM UTC)
  identifier                  = format("%s-%s-pg-db1", var.tags["environment"], var.tags["project"]) 
  parameter_group_name       = aws_db_parameter_group.postgres_params.name 



  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name # Parameter group

  tags = {
    Name = format("%s-%s-postgres-sg", var.tags["environment"], var.tags["project"])
  }
}




