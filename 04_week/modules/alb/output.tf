output "alb_target_group_arn" {
  description = "ALB Target group ARN"
  value       = aws_alb_target_group.this.arn
}

output "alb_sg_id" {
  description = "Security Group ID of ALB"
  value       = module.ecs_alb_sg.id
}
