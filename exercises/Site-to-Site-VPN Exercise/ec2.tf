resource "aws_instance" "Instance1" {
  ami           = var.latest_ami_id
  instance_type = "t2.micro"
  key_name      = var.key_pair

  tags = {
    Name = "IDC-CGW"
  }
  network_interface {
    network_interface_id = aws_network_interface.Instance1ENIEth0.id
    device_index         = 0
  }
  user_data = base64encode(file("${path.module}/user_data/user_data_idc_cgw.sh.tpl"))
}

resource "aws_instance" "Instance2" {
  ami             = var.latest_ami_id
  instance_type   = "t2.micro"
  key_name        = var.key_pair
  subnet_id       = aws_subnet.Subnet2.id
  security_groups = [aws_security_group.SG2.id]
  private_ip      = "10.60.1.100"

  tags = {
    Name = "IDC-EC2"
  }
  user_data = base64encode(file("${path.module}/user_data/user_data_idc_ec2.sh.tpl"))
}

resource "aws_instance" "Instance3" {
  ami                         = var.latest_ami_id
  instance_type               = "t2.micro"
  key_name                    = var.key_pair
  subnet_id                   = aws_subnet.VPCAWSSubnet.id
  security_groups             = [aws_security_group.SG3.id]
  private_ip                  = "10.50.1.100"
  associate_public_ip_address = true

  tags = {
    Name = "AWS-EC2"
  }
  user_data = base64encode(file("${path.module}/user_data/user_data_aws_ec2.sh.tpl"))
}

