variable "subnet_group_name" {
  description = "The RDS subnets group name"
  type = string
}

variable "security_group_id" {
  description = "The id of the security group for the RDS database"
  type        = string
}

variable "db_name" {
  description = "The RDS database name"
  type = string
}

variable "db_username" {
  description = "The username for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true
}