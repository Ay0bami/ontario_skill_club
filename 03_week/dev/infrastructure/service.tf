resource "aws_ecs_service" "this" {
  name                               = "${local.prefix}-service"
  cluster                            = aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = var.service_desired_count
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 60
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [module.ecs_service_sg.id]
    subnets          = module.dynamic_subnets.private_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.this.arn
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


module "ecs_service_sg" {
  source     = "cloudposse/security-group/aws"
  version    = "2.0.0-rc1"
  attributes = ["ecs-primary"]

  # Allow unlimited egress
  allow_all_egress = true

  rule_matrix = [
    # Allow any of these security groups
    {
      source_security_group_ids = [module.ecs_alb_sg.id]
      self                      = null
      rules = [
        {
          key         = "OTHERS"
          type        = "ingress"
          from_port   = 31000
          to_port     = 61000
          protocol    = "tcp"
          description = "Allow non privileged ports"
        },
        {
          key         = "HTTPALB"
          type        = "ingress"
          from_port   = 3000
          to_port     = 3000
          protocol    = "tcp"
          description = "Allow HTTP from ALB"
        }
      ]
    }
  ]

  vpc_id = module.vpc.vpc_id
}