resource "aws_secretsmanager_secret" "planty_db_secret" {
  name        = "${var.db_name}-secret"
  description = "RDS credentials for ${var.db_name}"
}

resource "aws_secretsmanager_secret_version" "planty_db_secret_version" {
  secret_id = aws_secretsmanager_secret.planty_db_secret.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}