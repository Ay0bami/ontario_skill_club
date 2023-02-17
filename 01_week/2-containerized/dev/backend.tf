terraform {
  backend "s3" {
    bucket = "dev-ontario-club-islamiyat"
    key    = "core-infrastructure-week1/terraform.tfstate"
    region = "us-east-1"
  }
}