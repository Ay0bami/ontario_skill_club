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

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}


variable "alb_sg_id" {
  type        = string
  description = "ALB Security Group ID"
}
