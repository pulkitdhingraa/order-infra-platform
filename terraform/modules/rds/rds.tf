resource "aws_security_group" "rds" {
    name = "rds-sg"
    vpc_id = var.vpc_id
    
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = [aws_security_group.eks.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_db_subnet_group" "rds" {
  name = "rds-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "rds" {
  identifier = "postgres-db"
  engine = "postgres"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  db_subnet_group_name = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible = false
  skip_final_snapshot = true

  username = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)["username"]
  password = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)["password"]
  db_name = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)["dbname"]
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = var.secret_arn
}