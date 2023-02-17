# Get Route 53 Zone id from the remote state
data "aws_region" "current" {}

locals {
  prefix = "${var.namespace}-${var.stage}-${var.name}"
  region = data.aws_region.current.name
}

data "terraform_remote_state" "hostedzone" {
  backend = "s3"
  config = {
    bucket = "${local.prefix}-state"
    key    = "hostedzone/terraform.tfstate"
    region = local.region
  }
}
# Request certificate from AWS ACM

resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = ["*.${var.domain_name}"]

  tags = {
    Name        = "${local.prefix}-cert"
    Environment = var.stage
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Add Route 53 records to allow domain validation_method

resource "aws_route53_record" "this" {
  for_each = {
    for rec in aws_acm_certificate.this.domain_validation_options : rec.domain_name => {
      name   = rec.resource_record_name
      record = rec.resource_record_value
      type   = rec.resource_record_type
    }
  }

  zone_id = data.terraform_remote_state.hostedzone.outputs.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [
    each.value.record,
  ]

  allow_overwrite = true
}

# Validate the certificate

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}

