resource "aws_s3_bucket" "danie-s3-bucket" {
  bucket = format("%s-%s-s3bucket", var.tags["environment"], var.tags["project"])
  # acl    = "private"
}


resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.danie-s3-bucket.id
  versioning_configuration {
    status = var.status
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = format("%s-%s-dynamodb", var.tags["environment"], var.tags["project"])
  hash_key       = var.hash_key      
  read_capacity  = var.read_capacity 
  write_capacity = var.write_capacity

  attribute {
    name = var.name
    type = var.type
  }
}

