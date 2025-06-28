variable "vpc_name" {
  description = "Name of custom vpc"
  type = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets cidr"
  type = list(string)
}

variable "private_subnets" {
  description = "List of private subnets cidr"
  type = list(string)
}