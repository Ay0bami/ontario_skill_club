terraform {
  backend "s3" {
    bucket = "dev-acs730-week5-igeiman"
    key    = "core-infrastructure-week2/terraform.tfstate"
    region = "us-east-1"
  }
}