module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "12.2.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.17"
  subnets         = data.aws_subnet_ids.subnets.ids
  vpc_id          = data.aws_vpc.vpc.id

  # Endpoint Access
  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.public_api_cidrs

  # Node Groups
  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  node_groups = {
    node-group-01 = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 2
      instance_type = "t2.medium"
      
      k8s_labels = {
        Environment = "test"
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }

      additional_tags = {
        "kubernetes.io/cluster/${var.cluster_name}" = "owned"
      }
    }
  }

  #worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  #map_roles                            = var.map_roles
  #map_users = var.map_users
  #map_accounts                         = var.map_accounts

  tags = {
    "Terraform"   = "true"
    "Environment" = data.aws_vpc.vpc.tags["Name"]
    "Application" = "EKS"
  }

}