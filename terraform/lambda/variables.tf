
variable "labrole_arn" {
  description = "LabRole ARN. It can be found in IAM > Roles"
  type = string
  sensitive = true
}

variable "lambda_subnet_ids" {
  description = "The list of subnet IDs for the Lambda functions"
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID for the Lambda functions"
  type        = string
}
