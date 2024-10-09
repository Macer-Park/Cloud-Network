resource "aws_instance" "endpoint_public_ec2" {
  instance_type               = "t2.micro"
  ami                         = var.ami
  key_name                    = var.keypair
  subnet_id                   = aws_subnet.endpoint_public_sn.id
  security_groups             = [aws_security_group.endpoint_security_group.id]
  associate_public_ip_address = true

  tags = {
    Name = "endpoint_public_ec2"
  }
}

resource "aws_instance" "endpoint_private_ec2" {
  instance_type   = "t2.micro"
  ami             = var.ami
  key_name        = var.keypair
  subnet_id       = aws_subnet.endpoint_private_sn.id
  security_groups = [aws_security_group.endpoint_security_group.id]

  tags = {
    Name = "endpoint_private_ec2"
  }

  user_data = base64encode(file("${path.module}/user_data/user_data_private_ec2.sh.tpl"))
}