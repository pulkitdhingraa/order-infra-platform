resource "aws_s3_bucket" "db_backup" {
    bucket = "ou-db-backups-${random_id.suffix.hex}"
    force_destroy = true
}

resource "random_id" "suffix" {
    byte_length = 4
}