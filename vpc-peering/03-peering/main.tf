provider "aws" {
  region  = "us-east-1"
  profile = "default" # Profiles assumed to be in ~/.aws/credentials
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "simple-example"
  }
}

data "aws_route_tables" "rt" {
  vpc_id = data.aws_vpc.vpc.id
}

module "multi-account-peering" {
  source              = "github.com/isaaguilar/terraform-aws-multi-account-peering"
  auto_accept_peering = true
  name                = "peering-example"

  # Requester Data

  this_vpc_id          = data.aws_vpc.vpc.id
  this_cidr_block      = "10.0.0.0/16"
  this_route_table_ids = data.aws_route_tables.rt.ids

  # Accepter Data

  peer_region          = "us-east-1"
  peer_profile         = "eng" # Profiles assumed to be in ~/.aws/credentials
  peer_vpc_id          = "vpc-0f5b69fdf15a04c15"
  peer_cidr_block      = "10.1.0.0/16"
  peer_route_table_ids = []

  tags = {
    ManagedWith = "terraform"
  }
}