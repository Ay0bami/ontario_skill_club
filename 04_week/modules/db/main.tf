data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  prefix = "${var.namespace}-${var.stage}-${var.name}"
  region = data.aws_region.current.name
}

# RDS Instance
resource "aws_db_instance" "this" {
  identifier             = "${local.prefix}-db"
  allocated_storage      = "25"
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  parameter_group_name   = "default.mysql5.7"
  db_name                = "todoapp"
  username               = "todoapp"
  password               = random_password.this.result
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [module.rds_sg.id]
  skip_final_snapshot    = true
  deletion_protection    = false
}

# RDS Subnet Group
resource "aws_db_subnet_group" "this" {
  name       = "${local.prefix}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${local.prefix}-rds-subnet-group"
  }
}

# RDS MySQL Security Group
module "rds_sg" {
  source     = "cloudposse/security-group/aws"
  version    = "2.0.0-rc1"
  attributes = ["rds-sg"]

  # Allow unlimited egress
  allow_all_egress = true

  rule_matrix = [
    # Allow any of these security groups
    {
      source_security_group_ids = [var.ecs_sg_id]
      self                      = null
      rules = [
        {
          key         = "ECSINGRESS"
          type        = "ingress"
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          description = "Allow ingress to mysql DB"
        },
      ]
    }
  ]

  vpc_id = var.vpc_id
}

resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "this" {
  name                    = "todo-db-password"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = random_password.this.result
}

resource "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = random_password.this.result
}
