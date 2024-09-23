output "planty_db_secret_arn" {
  value = aws_secretsmanager_secret.planty_db_secret.arn
}