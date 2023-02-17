
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_iam_role" "labrole" {
  name = "LabRole"
}

data "terraform_remote_state" "this" {
  backend = "s3"
  config = {
    bucket = "${local.prefix}-state"
    key    = "${var.namespace}-core-infrastructure/terraform.tfstate"
    region = local.region
  }
}

locals {
  prefix       = "${var.namespace}-${var.stage}-${var.name}"
  region       = data.aws_region.current.name
  ecr_repo     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${local.prefix}-repo"
  log_group    = aws_cloudwatch_log_group.this.name
  lab_role_arn = data.aws_iam_role.labrole.arn
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${local.prefix}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = local.lab_role_arn
  task_role_arn            = local.lab_role_arn
  container_definitions = jsonencode([{
    name      = "${local.prefix}-container"
    image     = local.ecr_repo
    essential = true
    environment = [
      { "name" : "REGION", "value" : local.region },
      { "name" : "RDS_PORT", "value" : data.terraform_remote_state.this.outputs.db_settings.port },
      { "name" : "RDS_HOSTNAME", "value" : data.terraform_remote_state.this.outputs.db_settings.hostname },
      { "name" : "RDS_DBNAME", "value" : data.terraform_remote_state.this.outputs.db_settings.dbname },
      { "name" : "RDS_USERNAME", "value" : data.terraform_remote_state.this.outputs.db_settings.username },
    ]
    secrets : [
      {
        "name" : "RDS_PASSWORD",
        "valueFrom" : data.terraform_remote_state.this.outputs.db_settings.pwd_arn
      }
    ]
    portMappings = [{
      protocol      = "tcp"
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = local.log_group
        awslogs-stream-prefix = "/aws/ecs"
        awslogs-region        = local.region
      }
    }
  }])

  tags = {
    Name        = "${local.prefix}-task"
    Environment = var.stage
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${local.prefix}-cloudwatch-log-group"

  tags = {
    Name        = "${local.prefix}-cloudwatch-log-group"
    Environment = var.stage
  }
}

resource "aws_cloudwatch_log_stream" "todo_container_cloudwatch_logstream" {
  name           = "${local.prefix}-cloudwatch-log-stream"
  log_group_name = aws_cloudwatch_log_group.this.name
}
