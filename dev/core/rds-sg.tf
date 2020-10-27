
module "rds-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.16.0"

  name            = "rds-sg"
  use_name_prefix = false
  description     = "secure postgres rds"
  vpc_id          = module.vpc.vpc_id


  ingress_with_cidr_blocks = [
    {
      description = "All public"
      from_port   = var.rds_port
      to_port     = var.rds_port
      protocol    = var.rds_protocol
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    "Terraform"   = "true"
    "Environment" = var.vpc_name
    "Application" = "RDS"
  }
}