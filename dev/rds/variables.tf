variable "region" {
  description = "region to deploy to, linux acedamy runs on us-east-2 and us-west-1"
  default     = "us-east-1"
}

variable "environment" {
  description = "environment tag used througout deployment"
  default     = "development"
}
