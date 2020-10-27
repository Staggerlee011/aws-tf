
resource "random_password" "pwd" {
  length           = 16
  special          = true
  override_special = "_%@/"
}

resource "aws_ssm_parameter" "ssm_user" {
  name        = "/global/rds/${var.rds_engine}/${var.rds_name}/usr/admin/username"
  description = "admin user name rds server ${var.rds_name}"
  type        = "SecureString"
  value       = var.rds_user
}

resource "aws_ssm_parameter" "ssm_pwd" {
  name        = "/global/rds/${var.rds_engine}/${var.rds_name}/usr/admin/password"
  description = "admin user password rds server ${var.rds_name}"
  type        = "SecureString"
  value       = random_password.pwd.result
}

resource "aws_ssm_parameter" "ssm_add" {
  name        = "/global/rds/${var.rds_engine}/${var.rds_name}/address"
  description = "address of rds instance"
  type        = "SecureString"
  value       = module.db.this_db_instance_address
}

resource "aws_ssm_parameter" "ssm_port" {
  name        = "/global/rds/${var.rds_engine}/${var.rds_name}/port"
  description = "port used by rds instance"
  type        = "SecureString"
  value       = module.db.this_db_instance_port
}
