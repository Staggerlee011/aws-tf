
variable "rds_engine" {
  description = "type of rds instance"
  type        = string
  default     = "postgres"
}

variable "rds_name" {
  description = "identifier / name for the rds service"
  type        = string
  default     = "appdevrds"
}

variable "rds_user" {
  description = "admin user for rds postgres"
  type        = string
  default     = "postgres"
}
