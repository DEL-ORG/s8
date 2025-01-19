variable "region" {
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

variable "desired_capacity" {
  type    = number
}

variable "min_size" {
  type    = number
}

variable "max_size" {
  type    = number
}

variable "health_check_type" {
  type    = string
}

variable "health_check_grace_period" {
  type    = string
}

variable "scaleUp" {
  type = map(string)
}

variable "scaleDown" {
  type = map(string)
}
variable "ttl" {
  type    = number
}