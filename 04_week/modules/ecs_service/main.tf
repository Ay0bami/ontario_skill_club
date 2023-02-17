data "aws_region" "current" {}

locals {
  prefix = "${var.namespace}-${var.stage}-${var.name}"
  region = data.aws_region.current.name
}

data "terraform_remote_state" "this" {
  backend = "s3"
  config = {
    bucket = "${local.prefix}-state"
    key    = "${var.namespace}-core-infrastructure/terraform.tfstate"
    region = local.region
  }
}

resource "aws_ecs_service" "this" {
  name                               = "${local.prefix}-service"
  cluster                            = data.terraform_remote_state.this.outputs.ecs_id
  task_definition                    = var.td_arn
  desired_count                      = var.service_desired_count
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 60
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [data.terraform_remote_state.this.outputs.ecs_service_sg_id]
    subnets          = data.terraform_remote_state.this.outputs.private_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = data.terraform_remote_state.this.outputs.alb_target_group_arn
    container_name   = "${local.prefix}-container"
    container_port   = var.container_port
  }

  # we ignore task_definition changes as the revision changes on deploy
  # of a new version of the application
  # desired_count is ignored as it can change due to autoscaling policy
  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}
