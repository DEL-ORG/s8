variable "region" {
  type    = string
}
variable "hash_key" {
  type    = string
}
variable "type" {
  type    = string
}
variable "read_capacity" {
  type    = string
}
variable "write_capacity" {
  type    = string
}
variable "status" {
  type    = string
}
variable "name" {
  type    = string
}
variable "tags" {
  type = map(any)
}

     
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region to deploy resources in."
}
variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket. Must be globally unique."
}
variable "environment" {
  type        = string
  description = "The environment for tagging purposes (e.g., Dev, Prod)."
  default     = "Dev"
}





    
          