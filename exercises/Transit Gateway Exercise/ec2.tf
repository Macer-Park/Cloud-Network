resource "aws_instance" "VPC0Instance1" {
  ami             = var.latest_ami_id
  instance_type   = "t2.micro"
  key_name        = var.key_pair
  subnet_id       = aws_subnet.VPC0Subnet1.id
  security_groups = [aws_security_group.VPC0SG1.id]
  private_ip      = "10.0.1.10"

  tags = {
    Name = "VPC0-Instance1"
  }

  user_data = base64encode(file("${path.module}/user_data/user_data_VPC0-Instance1.sh.tpl"))
}

resource "aws_instance" "VPC1Instance1" {
  ami             = var.latest_ami_id
  instance_type   = "t2.micro"
  key_name        = var.key_pair
  subnet_id       = aws_subnet.VPC1Subnet1.id
  security_groups = [aws_security_group.VPC1SG1.id]
  private_ip      = "10.10.1.10"

  tags = {
    Name = "VPC1-Instance1"
  }

  user_data = base64encode(file("${path.module}/user_data/user_data_VPC1-Instance1.sh.tpl"))
}

resource "aws_instance" "VPC1Instance2" {
  ami             = var.latest_ami_id
  instance_type   = "t2.micro"
  key_name        = var.key_pair
  subnet_id       = aws_subnet.VPC1Subnet2.id
  security_groups = [aws_security_group.VPC1SG1.id]
  private_ip      = "10.10.2.10"

  tags = {
    Name = "VPC1-Instance2"
  }

  user_data = base64encode(file("${path.module}/user_data/user_data_VPC1-Instance2.sh.tpl"))
}

resource "aws_instance" "VPC2Instance1" {
  ami             = var.latest_ami_id
  instance_type   = "t2.micro"
  key_name        = var.key_pair
  subnet_id       = aws_subnet.VPC2Subnet1.id
  security_groups = [aws_security_group.VPC2SG1.id]
  private_ip      = "10.20.1.10"

  tags = {
    Name = "VPC2-Instance1"
  }

  user_data = base64encode(file("${path.module}/user_data/user_data_VPC2-Instance1.sh.tpl"))
}

resource "aws_instance" "VPC2Instance2" {
  ami             = var.latest_ami_id
  instance_type   = "t2.micro"
  key_name        = var.key_pair
  subnet_id       = aws_subnet.VPC2Subnet2.id
  security_groups = [aws_security_group.VPC2SG1.id]
  private_ip      = "10.20.2.10"

  tags = {
    Name = "VPC2-Instance2"
  }

  user_data = base64encode(file("${path.module}/user_data/user_data_VPC2-Instance2.sh.tpl"))
}