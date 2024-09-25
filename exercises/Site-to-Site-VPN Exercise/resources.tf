# Create Key Pair
resource "aws_key_pair" "key" {
  key_name   = "my-key-pair"
  public_key = file(var.public_key_path)
}

# VPC1 (IDC-VPC1)
resource "aws_vpc" "vpc1" {
  cidr_block           = "10.60.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "IDC-VPC1"
  }
}

# Internet Gateway for VPC1
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "IDC-IGW1"
  }
}

# Route Table for VPC1 Public Subnet
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "IDC-PublicRT1"
  }
}

# Default Route to Internet Gateway in VPC1
resource "aws_route" "default_route1" {
  route_table_id         = aws_route_table.rt1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw1.id
}

# Subnet1 in VPC1
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.60.0.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "IDC-VPC1-Subnet1"
  }
}

# Associate Subnet1 with Route Table
resource "aws_route_table_association" "rt_assoc1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}

# VPC2 (AWS-VPC2)
resource "aws_vpc" "vpc2" {
  cidr_block           = "10.50.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "AWS-VPC2"
  }
}

# Internet Gateway for VPC2
resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "AWS-IGW2"
  }
}

# Route Table for VPC2 Public Subnet
resource "aws_route_table" "vpcaws_subnet_route_table" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "AWS-PublicRT"
  }
}

# Default Route to Internet Gateway in VPC2
resource "aws_route" "vpcaws_internet_route" {
  route_table_id         = aws_route_table.vpcaws_subnet_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw2.id
}

# Subnet in VPC2
resource "aws_subnet" "vpcaws_subnet" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.50.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "AWS-VPC2-Subnet"
  }
}

# Associate Subnet with Route Table in VPC2
resource "aws_route_table_association" "vpcaws_subnet_route_table_association" {
  subnet_id      = aws_subnet.vpcaws_subnet.id
  route_table_id = aws_route_table.vpcaws_subnet_route_table.id
}

# Security Group for Instance1 (IDC-CGW)
resource "aws_security_group" "sg1" {
  name        = "VPC1-IDC-CGW-SG"
  description = "VPC1-IDC-CGW-SG"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4500
    to_port     = 4500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPC1-IDC-CGW-SG"
  }
}

# Network Interface for Instance1
resource "aws_network_interface" "instance1_eni_eth0" {
  subnet_id         = aws_subnet.subnet1.id
  private_ips       = ["10.60.0.100"]
  security_groups   = [aws_security_group.sg1.id]
  source_dest_check = false

  tags = {
    Name = "IDC-CGW eth0"
  }
}

# Elastic IP for Instance1
resource "aws_eip" "vpc_eip1" {
  domain = "vpc"
}

# Associate EIP with ENI of Instance1
resource "aws_eip_association" "eip_assoc1" {
  allocation_id        = aws_eip.vpc_eip1.id
  network_interface_id = aws_network_interface.instance1_eni_eth0.id
}

# Security Group for Instance2 (IDC-EC2)
resource "aws_security_group" "sg2" {
  name        = "VPC1-IDC-EC2-SG"
  description = "VPC1-IDC-EC2-SG"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPC1-IDC-EC2-SG"
  }
}

# Subnet2 in VPC1
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.60.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "IDC-VPC1-Subnet2"
  }
}

# Route Table for Subnet2 (Private Route Table)
resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "IDC-PrivateRT1"
  }
}

# Associate Subnet2 with Route Table rt2
resource "aws_route_table_association" "rt_assoc2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt2.id
}

# Instance1 (IDC-CGW)
resource "aws_instance" "instance1" {
  ami                    = data.aws_ssm_parameter.latest_ami.value
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key.key_name

  network_interface {
    network_interface_id = aws_network_interface.instance1_eni_eth0.id
    device_index         = 0
  }

  tags = {
    Name = "IDC-CGW"
  }

  user_data = templatefile("${path.module}/user_data_instance1.sh.tpl", {})

  depends_on = [aws_eip_association.eip_assoc1]
}

# Removed the unsupported route via instance

# Instance2 (IDC-EC2)
resource "aws_instance" "instance2" {
  ami                    = data.aws_ssm_parameter.latest_ami.value
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key.key_name
  subnet_id              = aws_subnet.subnet2.id
  private_ip             = "10.60.1.100"
  vpc_security_group_ids = [aws_security_group.sg2.id]
  associate_public_ip_address = false

  tags = {
    Name = "IDC-EC2"
  }

  user_data = templatefile("${path.module}/user_data_instance2.sh.tpl", {})
}

# Security Group for Instance3 (AWS-EC2)
resource "aws_security_group" "sg3" {
  name        = "VPC2-AWS-EC2-SG"
  description = "VPC2-AWS-EC2-SG"
  vpc_id      = aws_vpc.vpc2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPC2-AWS-EC2-SG"
  }
}

# Instance3 (AWS-EC2)
resource "aws_instance" "instance3" {
  ami                    = data.aws_ssm_parameter.latest_ami.value
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key.key_name
  subnet_id              = aws_subnet.vpcaws_subnet.id
  private_ip             = "10.50.1.100"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg3.id]

  tags = {
    Name = "AWS-EC2"
  }

  user_data = templatefile("${path.module}/user_data_instance3.sh.tpl", {})
}

# VPN Gateway in VPC2
resource "aws_vpn_gateway" "vpc2_vpngw" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "AWS-VPNGW"
  }
}

# Customer Gateway pointing to Instance1's EIP
resource "aws_customer_gateway" "vpc2_cgw" {
  bgp_asn    = 65000
  ip_address = aws_eip.vpc_eip1.public_ip
  type       = "ipsec.1"

  tags = {
    Name = "IDC-VPN-CGW"
  }
}

# VPN Connection between VPC2 and Customer Gateway
resource "aws_vpn_connection" "vpcaws_vpn_connection" {
  vpn_gateway_id        = aws_vpn_gateway.vpc2_vpngw.id
  customer_gateway_id   = aws_customer_gateway.vpc2_cgw.id
  type                  = "ipsec.1"
  static_routes_only    = true

  tunnel1_preshared_key = "cloudneta"

  tags = {
    Name = "AWS-VPNConnection-IDC"
  }
}

# Route to 10.60.0.0/16 via VPN Connection in VPC2 (already handled by route propagation)

# Enable Route Propagation on Route Table in VPC2
resource "aws_vpn_gateway_route_propagation" "vpn_aws_gateway_route_propagation" {
  vpn_gateway_id = aws_vpn_gateway.vpc2_vpngw.id
  route_table_id = aws_route_table.vpcaws_subnet_route_table.id
}

# VPN Gateway in VPC1
resource "aws_vpn_gateway" "vpc1_vpngw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "IDC-VPNGW"
  }
}

# Attach the VPN Gateway to VPC1
resource "aws_vpn_gateway_attachment" "vpc1_vpngw_attach" {
  vpc_id        = aws_vpc.vpc1.id
  vpn_gateway_id = aws_vpn_gateway.vpc1_vpngw.id
}

# VPN Connection between VPC1 and Customer Gateway (reusing the same customer gateway)
resource "aws_vpn_connection" "vpc1_vpn_connection" {
  vpn_gateway_id        = aws_vpn_gateway.vpc1_vpngw.id
  customer_gateway_id   = aws_customer_gateway.vpc2_cgw.id
  type                  = "ipsec.1"
  static_routes_only    = true

  tunnel1_preshared_key = "cloudneta"

  tags = {
    Name = "IDC-VPNConnection-AWS"
  }
}

# Enable Route Propagation on Route Table in VPC1
resource "aws_vpn_gateway_route_propagation" "vpn_idc_gateway_route_propagation" {
  vpn_gateway_id = aws_vpn_gateway.vpc1_vpngw.id
  route_table_id = aws_route_table.rt2.id
}

