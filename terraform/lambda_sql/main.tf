resource "aws_lambda_function" "create_tables" {
    function_name = "rds_create_tables"
    runtime       = "nodejs20.x"
    handler       = "lambda_sql.handler"
    role          = var.labrole_arn

    environment {
        variables = {
            DB_NAME     = "postgres"
            DB_USER     = var.db_username
            DB_PASSWORD = var.db_password
            DB_HOST     = var.proxy_host
            DB_PORT     = var.db_port
        }
    }

    filename = "${path.root}/../backend/lambda_sql/lambda_sql.zip"

    vpc_config {
        subnet_ids         = var.subnet_ids
        security_group_ids = [var.lambda_security_group_id]
    }
}