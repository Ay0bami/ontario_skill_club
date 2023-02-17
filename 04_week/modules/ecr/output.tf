output "ecr_repo_id" {
  description = "ECR repo ID"
  value       = aws_ecr_repository.this.id
}
