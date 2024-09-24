variable "proxy_host" {
  description = "The endpoint address of the RDS Proxy"
  type        = string
}

variable "db_username" {
  description = "The username to connect to the RDS database"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS database user"
  type        = string
}

variable "db_port" {
  description = "The port on which the database is listening"
  type        = string
}

variable "subnet_ids" {
  description = "The list of subnet IDs where the Lambda function will be deployed"
  type        = list(string)
}

variable "lambda_security_group_id" {
  description = "The security group ID associated with the Lambda function"
  type        = string
}

variable "labrole_arn" {
  description = "LabRole ARN. It can be found in IAM > Roles"
  type = string
  sensitive = true
}