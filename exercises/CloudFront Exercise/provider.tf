terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Provider configuration
provider "aws" {
  region = "sa-east-1" # Change to your desired region
}