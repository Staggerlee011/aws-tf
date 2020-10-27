module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.18.0"

  # size
  instance_class = "db.t2.micro"
  multi_az       = false

  # engine
  engine               = var.rds_engine
  engine_version       = "12"
  family               = "postgres12"
  major_engine_version = "12"

  # stroage
  allocated_storage = 5
  #storage_encrypted = true
  storage_type = "gp2"
  # iops =

  # user details
  identifier                          = var.rds_name
  name                                = var.rds_name
  username                            = var.rds_user
  password                            = random_password.pwd.result
  iam_database_authentication_enabled = true

  # networking
  port                   = 54321
  publicly_accessible    = true
  subnet_ids             = data.aws_subnet_ids.subnets.ids
  vpc_security_group_ids = [data.aws_security_group.rds-sg.id]

  # maintenance
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # monitoring
  #performance_insights_enabled          = true
  #performance_insights_retention_period = 7
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  create_monitoring_role          = true
  monitoring_role_name            = "app-dev-monitoring-role"
  monitoring_interval             = 60

  # Database Deletion Protection
  #final_snapshot_identifier = "appdevrds"
  deletion_protection = false

  tags = {
    "Terraform"   = "true"
    "Environment" = data.aws_vpc.vpc.tags["Name"]
    "Application" = "RDS"
  }

}
