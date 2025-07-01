module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
  cidr_block = var.cidr_block
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
}

module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  private_subnet_ids = module.vpc.private_subnet_ids
}