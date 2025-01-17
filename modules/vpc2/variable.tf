variable "cidr_block" {
  type = string
}

variable "destination_cidr_block" {
  type = string
}

variable "region" {
  type = string
}

variable "tags" {
  type = map(any)
}
