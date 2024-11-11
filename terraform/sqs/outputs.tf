output "queue_url" {
  description = "The URL of the main SQS queue"
  value       = aws_sqs_queue.plant_notifications.url
}

output "queue_arn" {
  description = "The ARN of the main SQS queue"
  value       = aws_sqs_queue.plant_notifications.arn
}

output "dlq_url" {
  description = "The URL of the Dead Letter Queue"
  value       = aws_sqs_queue.plant_notifications_dlq.url
}

output "dlq_arn" {
  description = "The ARN of the Dead Letter Queue"
  value       = aws_sqs_queue.plant_notifications_dlq.arn
}