terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  alias  = "seoul"
  region = "ap-northeast-2"
}

provider "aws" {
  alias  = "sao_paulo"
  region = "sa-east-1"
}

provider "aws" {
  alias  = "sydney"
  region = "ap-southeast-2"
}