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
variable "container_port" {
  type        = number
  description = "The port the application listens on"
  default     = 3000
}

variable "service_desired_count" {
  type        = number
  description = "The desired number of tasks per service"
  default     = 2
}
