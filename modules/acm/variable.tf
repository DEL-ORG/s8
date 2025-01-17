

variable "region" {
  type = string
}

variable "tags" {
  type = map(any)
}
variable "domain_name" {
  type = string
}

variable "subject_alternative_names" {
  type = string
}

