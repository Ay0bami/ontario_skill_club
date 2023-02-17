output "website_url" {
  description = "Access to the deployed website"
  value       = "www.${var.stage}.${var.domain_name}"
}

output "private_subnet_ids" {
  description = "List of private subnet ids"
  value       = module.vpc.private_subnet_ids
}

output "alb_target_group_arn" {
  description = "ALB Target group ARN"
  value       = module.alb.alb_target_group_arn
}

output "ecs_id" {
  description = "The ID of ECS cluster"
  value       = module.ecs.ecs_id
}

output "ecs_service_sg_id" {
  description = "ECS Service SG"
  value       = module.ecs.ecs_sg_id
}

output "db_settings" {
  description = "Database settings"
  value       = module.db.db_settings
}
