provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.39.0"
  name    = "dev"

  cidr = "20.10.0.0/16"

  azs              = ["us-east-1a", "us-east-1b"]
  private_subnets  = ["20.10.1.0/24", "20.10.2.0/24"]
  public_subnets   = ["20.10.11.0/24", "20.10.12.0/24"]
  database_subnets = ["20.10.21.0/24", "20.10.22.0/24"]

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    "Application"                                 = "EKS"
  }

  database_subnet_tags = {
    "Application" = "RDS"
  }

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_classiclink             = true
  enable_classiclink_dns_support = true

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_vpn_gateway = true

  tags = {
    Environment = var.environment
  }

  vpc_endpoint_tags = {
    Environment = var.environment
    Endpoint    = "true"
  }
}