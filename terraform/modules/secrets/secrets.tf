resource "aws_secretsmanager_secret" "postgres" {
    name = "postgres-creds"
}

resource "aws_secretsmanager_secret_version" "postgres" {
    secret_id = aws_secretsmanager_secret.postgres.id
    secret_string = jsonencode(var.postgres_secret)
}

resource "aws_secretsmanager_secret" "mongo" {
    name = "mongo-creds"
}

resource "aws_secretsmanager_secret_version" "mongo" {
    secret_id = aws_secretsmanager_secret.mongo.id
    secret_string = jsonencode(var.mongo_secret)
}