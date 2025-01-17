
# terraform {
#   backend "s3" {
#     bucket         = "danie-s3-bucket"
#     key            = "secret-manager/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "danie-s3-bucket-lock"
#   }
# }
