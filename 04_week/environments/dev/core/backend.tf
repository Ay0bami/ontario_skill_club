terraform {
  backend "s3" {
    bucket         = "week6-dev-todo-app-state"
    key            = "week6-core-infrastructure/terraform.tfstate"
    dynamodb_table = "week6-dev-todo-app-locks"
    region         = "us-east-1"
    encrypt        = true
  }
}
