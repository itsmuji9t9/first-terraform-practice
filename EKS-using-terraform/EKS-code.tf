module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.24.0"

  # v21 Updates: 'cluster_name' -> 'name' & 'cluster_version' -> 'kubernetes_version'
  name               = local.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = {
    cluster = "demo"
  }

  # Node group configuration v21 standard:
  eks_managed_node_groups = {
    node_group = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["c7i-flex.large"]

      min_size     = 2
      max_size     = 6
      desired_size = 2

      # Custom security group attach karne ka v21 tareeqa
      vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
    }
  }
}