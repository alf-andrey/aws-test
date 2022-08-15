terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 4.16"
      configuration_aliases = [aws.eu]
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = local.region_us
}

provider "aws" {
  region = local.region_eu
  alias  = "eu"
}

locals {
  name      = "aws-test"
  region_us = "us-east-2"
  region_eu = "eu-central-1"
  tags = {
    Owner       = "alf"
    Environment = "test"
    Name        = "aws-test"
  }
}

