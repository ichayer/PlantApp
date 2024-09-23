variable "vpc_region" {
  description = "The AWS region where the VPC will be created"
  type        = string
}

variable "subnet_group_name" {
  description = "The RDS subnets group name"
  type = string
}

variable "security_group_id" {
  description = "The ID of the Planty DB security group"
  type        = string
}

variable "db_username" {
  description = "The username for the PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the PostgreSQL database"
  type        = string
  sensitive   = true
}