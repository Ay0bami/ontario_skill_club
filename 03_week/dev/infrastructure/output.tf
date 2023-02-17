output "vpc_id" {
  description = "The ID of the VPC that hosts ECS cluster"
  value       = module.vpc.vpc_id
}

# DB related paramters
output "db_host" {
  description = "RDS MySQL hostname"
  value       = aws_db_instance.this.address
}
output "db_port" {
  description = " RDS MySQL port"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = " RDS MySQL DB name"
  value       = aws_db_instance.this.db_name
}

