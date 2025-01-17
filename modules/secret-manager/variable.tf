variable "aws_region" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "secret_names" {
  type = list(string)
}
