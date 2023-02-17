variable "stage" {
  type        = string
  description = "Deployment stage, e.g. dev, test, prod"
  default     = "dev"
}
variable "namespace" {
  type        = string
  description = "Project name"
  default     = "week6"
}

variable "name" {
  type        = string
  description = "No idea what name is for"
  default     = "todo-app"
}

variable "ipv4_primary_cidr_block" {
  type        = string
  description = <<-EOT
    The primary IPv4 CIDR block for the VPC.
    Either `ipv4_primary_cidr_block` or `ipv4_primary_cidr_block_association` must be set, but not both.
    EOT
  default     = "10.0.0.0/16"
}

variable "domain_name" {
  type        = string
  description = "DNS name you own"
  default     = "awscloudclub.ml"
}
