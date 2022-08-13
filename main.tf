terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = "1.2.7"
}

provider "aws" {
  region = "us-east-2"
  alias  = "us"
}

provider "aws" {
  region = "eu-central-1"
  alias  = "eu"
}
