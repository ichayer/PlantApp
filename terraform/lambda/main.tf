resource "null_resource" "build_backend" {
  for_each = local.lambda_functions
  provisioner "local-exec" {
    working_dir = "${path.root}/../backend"
    command     = "zip -r $OUT_FILE $IN_FILES"
    environment = {
      "OUT_FILE" = "${each.value.file}.zip"
      "IN_FILES" = "node_modules ${each.value.file}"
    }
    interpreter = ["bash", "-c"]
  }
}

resource "aws_lambda_function" "plant_functions" {
  depends_on    = [null_resource.build_backend]
  for_each      = local.lambda_functions
  function_name = each.key
  role          = each.value.role
  handler       = each.value.handler
  runtime       = "nodejs18.x"
  filename      = "${path.root}/../backend/${each.value.file}.zip"
  timeout       = 30

  environment {
    variables = {
      DB_NAME     = "postgres"
      DB_USER     = var.db_username
      DB_PASSWORD = var.db_password
      DB_HOST     = var.proxy_host
      DB_PORT     = var.db_port
      SQS_QUEUE_URL = var.sqs_url
      SQS_ENDPOINT  = var.sqs_endpoint
      SNS_EMAIL_TOPIC_ARN = var.sns_email_topic_arn
      S3_IMAGES_BUCKET_NAME = var.images_bucket_name
    }
  }

  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }

  dead_letter_config {
    target_arn = var.dlq_arn
  }
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = var.sqs_queue_arn
  function_name    = aws_lambda_function.plant_functions["processWateringNotification"].arn
  batch_size       = 10
  enabled          = true
}
