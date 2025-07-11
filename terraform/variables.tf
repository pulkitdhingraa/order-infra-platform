variable "vpc_name" {
  description = "Name of custom vpc"
  type = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type = string
}

variable "public_subnets" {
  description = "List of public subnets cidr"
  type = list(string)
}

variable "private_subnets" {
  description = "List of private subnets cidr"
  type = list(string)
}

variable "cluster_name" {
  description = "Name of aws eks cluster"
  type = string
}

variable "postgres_secret" {
  description = "Secret info for Postgres DB"
  type = map(string)
}

variable "mongo_secret" {
  description = "Secret info for Mongo DB"
  type = map(string)
}