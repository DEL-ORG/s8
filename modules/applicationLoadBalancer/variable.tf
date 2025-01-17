variable "region" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "load_balancer_type" {
  type = string
}

variable "enable_deletion_protection" {
  type = bool
}


variable "internal" {
  type = bool
}


variable "subnet_count" {
  type        = map(number)
  default     = {
    dev  = 2
    prod = 3
  }
}

variable "JenkinsTG" {
  type = map(any)
}


variable "SonarTG" {
  type = map(any)
}