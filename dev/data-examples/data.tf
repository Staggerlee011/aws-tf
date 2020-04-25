provider "aws" {
  region = "us-east-1"
}

## VPC 
data "aws_vpc" "vpc" {
  tags = {
    Name = "dev"
  }
}

output "vpc-out" {
  description = "return id for vpc"
  value = data.aws_vpc.vpc.id
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.vpc.id
}

output "all" {
  value = data.aws_subnet_ids.all
}

## Subnet Info
data "aws_subnet_ids" "destination" {                               
  vpc_id = data.aws_vpc.vpc.id
  tags   = {                                                        
    Name = "dev-db*"                                             
  }                                                                                                                             
}                                                                  
                                                                    
output "subnet" {
  value = data.aws_subnet_ids.destination.ids
}



data "aws_security_group" "sg" {
  name   = "default"
  vpc_id = data.aws_vpc.vpc.id
}

output "security" {
  value = "security group info"
}

output "sg" {
  value = data.aws_security_group.sg
}

