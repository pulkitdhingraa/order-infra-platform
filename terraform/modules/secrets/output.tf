output "pg_secret_arn" {
  value = aws_secretsmanager_secret_version.postgres.arn
}