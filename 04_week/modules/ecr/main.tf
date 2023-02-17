locals {
  prefix = "${var.namespace}-${var.stage}-${var.name}"
}

# Define ECR repo to store application images
resource "aws_ecr_repository" "this" {
  name         = "${local.prefix}-repo"
  force_delete = true

  tags = {
    Name = "${local.prefix}-repo"
  }
}

# Policy to keep 3 last images in the ECR repo
resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "keep last 3 images"
      action = {
        type = "expire"
      }
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 3
      }
    }]
  })
}
