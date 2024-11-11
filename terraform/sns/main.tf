resource "aws_sns_topic" "plant_notifications" {
  name = "plant-notifications-topic"
}

resource "aws_sns_topic_subscription" "sns_to_sqs_subscription" {
  topic_arn = aws_sns_topic.plant_notifications.arn
  protocol  = "sqs"
  endpoint  = var.queue_arn
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.plant_notifications.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.labrole_arn
        }
        Action = "SNS:Publish"
        Resource = aws_sns_topic.plant_notifications.arn
      }
    ]
  })
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.plant_notifications.arn
  protocol  = "email"
  endpoint  = var.notification_email
  endpoint_auto_confirms = true
}