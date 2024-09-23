variable "vpc_region" {
  description = "Region to deploy the application"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "lambda_subnet_count" {
  description = "Number of lambda subnets"
  type        = number
}

variable "rds_subnet_count" {
  description = "Number of RDS subnets"
  type        = number
}
