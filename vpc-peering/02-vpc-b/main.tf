provider "aws" {
  region  = "us-east-1"
  profile = "eng"
}


module "vpc2" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.44.0"
  cidr    = "10.1.0.0/16"
  name    = "conn2"
  azs     = ["us-east-1a", "us-east-1b"]

}