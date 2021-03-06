
data "aws_vpc" "vpc" {
  tags = {
    Name = "dev"
  }
}

## Subnet Info
data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "dev-db*"
  }
}

# security group for rds
data "aws_security_group" "rds-sg" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "rds-sg"
}