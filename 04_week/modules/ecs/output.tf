output "ecs_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.this.id
}

output "ecs_sg_id" {
  description = "ECS Service Security Group ID"
  value       = module.ecs_service_sg.id
}
