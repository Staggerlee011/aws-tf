variable "cidr" {
  description = "cidr range"
  type        = string
  default     = "10.0.0.0/16"
}


variable "aza" {
  description = "az range a"
  type        = string
  default     = "us-east-1a"
}

variable "azb" {
  description = "az range b"
  type        = string
  default     = "us-east-1b"
}