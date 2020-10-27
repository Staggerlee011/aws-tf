variable "vpc_name" {
  description = "name of the vpc created"
  type        = string
  default     = "dev"
}

variable "public_subnet_a" {
  description = "public subnet for az a"
  type        = string
  default     = "20.10.11.0/24"
}

variable "public_subnet_b" {
  description = "public subnet for az b"
  type        = string
  default     = "20.10.12.0/24"
}

variable "db_subnet_a" {
  description = "db subnet for az a"
  type        = string
  default     = "20.10.21.0/24"
}

variable "db_subnet_b" {
  description = "db subnet for az b"
  type        = string
  default     = "20.10.22.0/24"
}

variable "intra_subnet_a" {
  description = "intra subnet for az a"
  type        = string
  default     = "20.10.31.0/24"
}

variable "intra_subnet_b" {
  description = "intra subnet for az b"
  type        = string
  default     = "20.10.32.0/24"
}


################
# RDS SG     
################

variable "rds_port" {
  description = "Port used for rds postgres connections"
  default     = "54321"
}

variable "rds_protocol" {
  description = "protocol used for connecting to rds postgres instance"
  default     = "tcp"
}
