provider "aws" {
  region  = "us-east-1"
  profile = "default"
}


module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "2.44.0"
  cidr            = "10.0.0.0/16"
  name            = "simple-example"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  tags = {
    Environment = "dev"
    ManagedWith = "terraform"
  }

  vpc_tags = {
    Name        = "simple-example"
    Environment = "dev"
    ManagedWith = "terraform"
  }

}

