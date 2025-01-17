variable "region" {
  type    = string
}

variable "ami" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "key_name" {
  type    = string
}

variable "tags" {
  type = map(string)
}

variable "subnet_count" {
  type        = map(number)
  default     = {
    dev  = 1
    prod = 1
  }
}
