module "aws_sydney_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "SYDNEY-VPC"
  cidr = "10.0.0.0/16"

  azs            = ["ap-southeast-2a", "ap-southeast-2c"]
  public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "aws_sao_paulo_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name           = "SAOPAULO-VPC"
  cidr           = "10.0.0.0/16"
  azs            = ["us-east-1a", "us-east-1c"]
  public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}