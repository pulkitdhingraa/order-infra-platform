resource "aws_eks_cluster" "eks_cluster" {
    name = var.cluster_name
    role_arn = aws_iam_role.eks_cluster.arn

    vpc_config {
      subnet_ids = var.private_subnet_ids
    }

    depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy] 
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
            Service = "eks.amazonaws.com"
        }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster.name
}

resource "aws_security_group" "eks" {
  name = "eks-cluster-sg"
  vpc_id = var.vpc_id
}

resource "aws_launch_template" "eks_node_group" {
  vpc_security_group_ids = [aws_security_group.eks.id]
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name = var.cluster_name
  node_group_name = "eks-node-group"
  node_role_arn =  aws_iam_role.eks_node_group.arn
  subnet_ids = var.private_subnet_ids
  
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 2
    max_size = 3
    min_size = 0
  }

  launch_template {
    id = aws_launch_template.eks_node_group.id
    version = "$Latest"
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_role_policy_attachment.eks_worker_node,
    aws_iam_role_policy_attachment.eks_cni,
    aws_iam_role_policy_attachment.eks_registery
  ]
}

resource "aws_iam_role" "eks_node_group" {
    name = "eks-node-group-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole",
            Effect = "Allow",
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_registery" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.eks_node_group.name
}