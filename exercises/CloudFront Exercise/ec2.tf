module "terraform-public-ec2-module-set" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "SA-EC2"
  instance_type = "t2.micro"
  key_name      = var.key_pair
  monitoring    = true
  vpc_security_group_ids = [
    module.http_ssh_sg.security_group_id
  ]
  subnet_id  = module.aws_vpc.public_subnets[0]
  create_eip = true
  eip_domain = "vpc"

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {}))
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}