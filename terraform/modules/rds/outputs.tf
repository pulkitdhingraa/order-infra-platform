output "endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "db_name" {
  value = aws_db_instance.rds.db_name
}

output "arn" {
  value = aws_db_instance.rds.arn
}