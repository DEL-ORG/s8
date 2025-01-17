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

variable "subnet_count" {
  type        = map(number)
  default     = {
    dev  = 2
    prod = 3
  }
}
