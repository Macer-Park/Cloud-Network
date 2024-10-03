module "sydney_http_ssh_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "HTTP_SSH_Permit_SG"
  description = "Security group for HTTP & SSH publicly open"
  vpc_id      = module.aws_sydney_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "sao_paulo_http_ssh_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "HTTP_SSH_Permit_SG"
  description = "Security group for HTTP & SSH publicly open"
  vpc_id      = module.aws_sao_paulo_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "seoul_http_ssh_sg" {
  source              = "terraform-aws-modules/security-group/aws"
  name                = "HTTP_SSH_Permit_SG"
  description         = "Security group for HTTP & SSH publicly open"
  vpc_id              = module.aws_seoul_vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}