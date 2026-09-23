terraform {
  required_version = ">= 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "flomotlik-terraform-state"
    key            = "flomotlik.me/dns.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "flomotlik-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}
