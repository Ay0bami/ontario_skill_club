data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_iam_role" "labrole" {
  name = "LabRole"
}

locals {
  prefix       = "${var.namespace}-${var.stage}-${var.name}"
  region       = data.aws_region.current.name
  lab_role_arn = data.aws_iam_role.labrole.arn
}

module "vpc" {
  source                           = "cloudposse/vpc/aws"
  version                          = "2.0.0"
  namespace                        = var.namespace
  stage                            = var.stage
  name                             = var.name
  dns_hostnames_enabled            = true
  dns_support_enabled              = true
  ipv4_primary_cidr_block          = var.ipv4_primary_cidr_block
  assign_generated_ipv6_cidr_block = false
}

module "dynamic_subnets" {
  source                  = "cloudposse/dynamic-subnets/aws"
  version                 = "2.0.4"
  namespace               = var.namespace
  stage                   = var.stage
  name                    = var.name
  availability_zones      = ["us-east-1a", "us-east-1b"]
  private_subnets_enabled = true
  vpc_id                  = module.vpc.vpc_id
  igw_id                  = [module.vpc.igw_id]
  ipv4_cidr_block         = [module.vpc.vpc_cidr_block]
}
