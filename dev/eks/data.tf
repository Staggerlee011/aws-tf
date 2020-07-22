data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_availability_zones" "available" {
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "dev"
  }
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "dev-priv*"
  }
}

data "aws_security_group" "eks-sg" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "eks"
}