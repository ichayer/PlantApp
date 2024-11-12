variable "queue_arn" {
  description = "The ARN of the main SQS queue"
  type       = string
}

variable "labrole_arn" {
  description = "LabRole ARN. It can be found in IAM > Roles"
  type = string
  sensitive = true
}