resource "aws_lambda_function" "plant_functions" {
  for_each       = local.lambda_functions
  function_name  = each.key
  role           = each.value.role
  handler        = each.value.handler
  runtime        = "nodejs18.x"
  filename       = "${path.root}/../backend/lambdas.zip"

  environment {
    variables = {
      DB_NAME     = "postgres"
      DB_USER     = var.db_username
      DB_PASSWORD = var.db_password
      DB_HOST     = var.proxy_host
      DB_PORT     = var.db_port
    }
  }

  vpc_config {
    security_group_ids = [var.security_group_id]
    subnet_ids         = var.lambda_subnet_ids
  }
}