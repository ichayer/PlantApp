resource "aws_secretsmanager_secret" "planty_db_secret" {
  name        = "planty-db-secret"
  description = "RDS credentials for planty-db"
}

resource "aws_secretsmanager_secret_version" "planty_db_secret_version" {
  secret_id = aws_secretsmanager_secret.planty_db_secret.id

  secret_string = jsonencode({
    username = "postgres"
    password = "postgres"
    db_name  = var.db_name
  })
}