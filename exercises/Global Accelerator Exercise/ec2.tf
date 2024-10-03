module "sao_paulo_EC2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = {
    "1" = module.aws_sao_paulo_vpc.public_subnets[0] # sa-east-1a 
    "2" = module.aws_sao_paulo_vpc.public_subnets[1] # sa-east-1c
  }

  name = "SAOPAULO-EC2-${each.key}"

  instance_type = "t2.micro"
  key_name      = var.key_pair_A
  monitoring    = true
  vpc_security_group_ids = [
    module.sao_paulo_http_ssh_sg.security_group_id
  ]
  subnet_id  = each.value
  create_eip = true
  eip_domain = "vpc"

  user_data = base64encode(file("${path.module}/user_data/user_data_sao_paulo.sh.tpl"))
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


module "sydney_EC2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = {
    "1" = module.aws_sydney_vpc.public_subnets[0] # ap-southeast-2a 
    "2" = module.aws_sydney_vpc.public_subnets[1] # ap-southeast-2c
  }

  name = "SYDNEY-EC2-${each.key}"

  instance_type = "t2.micro"
  key_name      = var.key_pair_B
  monitoring    = true
  vpc_security_group_ids = [
    module.sydney_http_ssh_sg.security_group_id
  ]
  subnet_id  = each.value
  create_eip = true
  eip_domain = "vpc"

  user_data = base64encode(file("${path.module}/user_data/user_data_sao_paulo.sh.tpl"))
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}