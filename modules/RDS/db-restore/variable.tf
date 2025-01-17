variable "aws_region" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "PostgreSQL" {
  type = map(string)
}


variable "family" {
  type = string 
}
