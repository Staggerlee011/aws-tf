resource "aws_ssm_parameter" "vpc_id" {
  name        = "/global/vpc/id"
  description = "id of the vpc used for all services and resources in the account"
  type        = "SecureString"
  value       = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "vpc_name" {
  name        = "/global/vpc/name"
  description = "name of the vpc"
  type        = "SecureString"
  value       = var.vpc_name
}

resource "aws_ssm_parameter" "vpc_region" {
  name        = "/global/vpc/region"
  description = "region for all objects in the vpc"
  type        = "SecureString"
  value       = "eu-west-2"
}



