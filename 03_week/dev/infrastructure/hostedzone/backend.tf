terraform {
  backend "s3" {
    bucket = "dev-acs730-week5-igeiman"
    key    = "hostedone-week3/terraform.tfstate"
    region = "us-east-1"
  }
}