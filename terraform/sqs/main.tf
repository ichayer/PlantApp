resource "aws_sqs_queue" "plant_notifications_dlq" {
  name                      = "plant-notifications-dlq"
}

resource "aws_sqs_queue" "plant_notifications" {
  name                      = "plant-notifications-queue"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.plant_notifications_dlq.arn
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue_policy" "plant_notifications" {
  queue_url = aws_sqs_queue.plant_notifications.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.labrole_arn
        }
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.plant_notifications.arn
      }
    ]
  })
}