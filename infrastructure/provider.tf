terraform {
  required_version = ">= 1.6"

  backend "s3" {
    bucket = "staticlaunch-tfstate-emmanuel-2026"
    key = "dev/staticlaunch.tfstate"
    region = var.aws_region_tfstate
    dynamodb_table = "staticlaunch-terraform-locks"
    encrypt = true
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}