# Bootstrap: the things CI is NOT allowed to manage.
#
# Kept in a separate state on purpose. If the CI role lived in the same
# configuration it applies, it would need permission to read and edit its own
# IAM policy — a role that can rewrite its own permissions can grant itself
# anything, which defeats the point of scoping it.
#
# Apply this by hand, with your own credentials. It changes rarely.
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
    key            = "flomotlik.me/bootstrap.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "flomotlik-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}
