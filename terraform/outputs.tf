output "vpc_id" {
    value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "eks_cluter_name" {
  value = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "eks_cluster_certificate_authority" {
  value = module.eks.eks_cluster_certificate_authority
}

output "db_backup_bucket_id" {
  value = module.s3.bucket_id
}

output "rds_db_name" {
  value = module.rds.db_name
}