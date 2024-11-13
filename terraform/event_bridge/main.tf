resource "aws_cloudwatch_event_rule" "watering_notifications_rule" {
  name                = "watering-notifications-rule"
  schedule_expression = "cron(0 12 * * ? *)"
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.watering_notifications_rule.arn
}

resource "aws_cloudwatch_event_target" "watering_notifications_target" {
  rule      = aws_cloudwatch_event_rule.watering_notifications_rule.name
  arn       = var.lambda_arn
}
