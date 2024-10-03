module "aws_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "SaVPC"
  cidr = "10.0.0.0/16"

  azs            = ["sa-east-1a"]
  public_subnets = ["10.0.0.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}