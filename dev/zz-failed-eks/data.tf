
data "aws_vpc" "vpc" {
  tags = {
    Name = "dev"
  }
}

## Subnet Info
data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "dev-private*"
  }
}

## security group for eks
#data "aws_security_group" "eks-sg" {
#  vpc_id = data.aws_security_group.id
#  name   = "eks"
#}


data "aws_availability_zones" "available" {
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}