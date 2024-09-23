resource "aws_secretsmanager_secret" "planty_db_secret" {
  name        = "planty-db-secret"
  description = "RDS credentials for planty-db"
}

