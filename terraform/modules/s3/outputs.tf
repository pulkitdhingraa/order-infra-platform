output "bucket_id" {
  value = aws_s3_bucket.db_backup.id
}

output "bucket_domain_name" {
  value = aws_s3_bucket.db_backup.bucket_domain_name
}