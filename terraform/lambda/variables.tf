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

variable "sqs_url" {
  description = "The URL of the SQS Queue"
  type       = string
}

variable "dlq_arn" {
  description = "The ARN of the Dead Letter Queue"
  type       = string
}

variable "sqs_endpoint" {
  description = "The VPC endpoint URL for SQS"
  type        = string
}

variable "sns_email_topic_arn" {
  description = "ARN of the SNS topic for notifications"
  type        = string
}

variable "sqs_queue_arn" {
  description = "ARN of the SQS queue for notifications"
  type        = string
}

variable "images_bucket_name" {
  description = "S3 images bucket name"
  type        = string
}