variable "stage" {
  type        = string
  description = "Deployment stage, e.g. dev, test, prod"
  default     = "dev"
}
variable "namespace" {
  type        = string
  description = "Project name"
  default     = "week4"
}

variable "name" {
  type        = string
  description = "No idea what name is for"
  default     = "todo-app"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
  default     = []
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the ACM certificate"
}

variable "vpc_id" {
  type        = string
  description = "VPC Id"
}

variable "domain_name" {
  type        = string
  description = "DNS name you own"
}
