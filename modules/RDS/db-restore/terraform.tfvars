# aws_region = "us-east-2"
# family     = "postgres15"  

# tags =  {
#   "id"             = "2560"
#   "owner"          = "danniella kitio"
#   "teams"          = "DevOps"
#   "environment"    = "production"
#   "project"        = "doityourself"
#   "create_by"      = "danniella"
#   "cloud_provider" = "aws"
# }

# PostgreSQL = {
#   allocated_storage            =  20            
#   max_allocated_storage        =  100           
#   engine                       =  "postgres"
#   engine_version               =  "15.8"        
#   instance_class               =  "db.t3.micro" 
#   skip_final_snapshot          =  true                    
#   auto_minor_version_upgrade   =  true
#   allow_major_version_upgrade  =  false
#   multi_az                     =  true
#   backup_retention_period      =   7    
#   deletion_protection          =   false 
#   ##maintenance_window         =  "wed:01:00-wed:02:00" 
#   family                       = "postgres15" 
#   publicly_accessible         = false
# }