module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.51.0"
  name    = var.vpc_name

  cidr = "20.10.0.0/16"

  azs              = ["us-east-1a", "us-east-1b"]
  public_subnets   = [var.public_subnet_a, var.public_subnet_b]
  database_subnets = [var.db_subnet_a, var.db_subnet_b]
  intra_subnets    = [var.intra_subnet_a, var.intra_subnet_b]

  public_subnet_tags = {
    "kubernetes.io/cluster/app-dev-eks" = "shared"
    "kubernetes.io/role/elb"            = "1"
    "Application"                       = "EKS"
    "Terraform"                         = "true"
    "Environment"                       = var.vpc_name
  }

  database_subnet_tags = {
    "Application" = "RDS"
    "Terraform"   = "true"
    "Environment" = var.vpc_name
  }

  intra_subnet_tags = {
    "Application" = "LAMBDA"
    "Terraform"   = "true"
    "Environment" = var.vpc_name
  }

  # set up gateways
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = true

  # set up rds to be public (ip blocking is used in sg to restrict access to azure-devops / workstations)
  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true

  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    "Terraform"   = "true"
    "Environment" = var.vpc_name
  }
}

