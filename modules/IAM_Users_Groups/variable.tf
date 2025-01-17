variable "aws_region" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "dev_user" {
  default = ["user1", "user2", "user3"]
}

variable "devops_user" {
  default = ["devops", "devops", "devops3"]
}