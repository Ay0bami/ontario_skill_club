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

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
  default     = []
}

variable "interface_endpoints" {
  type        = list(string)
  description = "List of ECR endpoints"
  default     = ["ecr.dkr", "ecr.api", "ecs-agent", "ecs-telemetry", "ecs"]
}

variable "private_route_table_ids" {
  type        = list(string)
  description = "List of route tables associated with private subnets"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC Id"
}

variable "ecs_sg_id" {
  type        = string
  description = "Security Group ID of ECS service"

}

