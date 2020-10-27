
variable "cluster_name" {
  description = "Name of eks cluster"
  type        = string
  default     = "dev-eks"
}


variable "public_api_cidrs" {
  description = "List of CIDRs allowed to connect to the public api"
  type        = list(string)
  default = [
    "0.0.0.0/0"
  ]
}