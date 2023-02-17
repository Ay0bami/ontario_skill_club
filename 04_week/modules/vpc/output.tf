output "vpc_id" {
  description = "The ID of the VPC that hosts ECS cluster"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "List of private subnet ids"
  value       = module.dynamic_subnets.private_subnet_ids
}

output "public_subnet_ids" {
  description = "List of public subnet ids"
  value       = module.dynamic_subnets.public_subnet_ids
}

output "private_route_table_ids" {
  description = "List of private route table ids"
  value       = module.dynamic_subnets.private_route_table_ids
}
