resource "aws_sns_topic" "plant_notifications" {
  name = "plant-notifications-topic"
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