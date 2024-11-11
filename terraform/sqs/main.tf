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