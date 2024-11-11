resource "aws_sns_topic" "plant_notifications" {
  name = "plant-notifications-topic"
}

resource "aws_sns_topic_subscription" "sns_to_sqs_subscription" {
  topic_arn = aws_sns_topic.plant_notifications.arn
  protocol  = "sqs"
  endpoint  = var.queue_arn
}
