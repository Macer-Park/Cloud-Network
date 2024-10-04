resource "aws_vpc" "VPC1" {
  cidr_block           = "10.60.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "IDC-VPC1"
  }
}

resource "aws_internet_gateway" "InternetGateway1" {
  tags = {
    Name = "IDC-IGW1"
  }
}

resource "aws_internet_gateway_attachment" "InternetGatewayAttachment1" {
  internet_gateway_id = aws_internet_gateway.InternetGateway1.id
  vpc_id              = aws_vpc.VPC1.id
}

resource "aws_vpc" "VPC2" {
  cidr_block           = "10.50.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "AWS-VPC2"
  }
}

resource "aws_internet_gateway" "InternetGateway2" {
  tags = {
    Name = "AWS-IGW2"
  }
}

resource "aws_internet_gateway_attachment" "InternetGatewayAttachment2" {
  internet_gateway_id = aws_internet_gateway.InternetGateway2.id
  vpc_id              = aws_vpc.VPC2.id
}

resource "aws_route_table" "RouteTable1" {
  vpc_id = aws_vpc.VPC1.id
  tags = {
    Name = "IDC-PublicRT1"
  }
}

resource "aws_route" "DefaultRoute1" {
  route_table_id         = aws_route_table.RouteTable1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.InternetGateway1.id

  depends_on = [aws_internet_gateway_attachment.InternetGatewayAttachment1]
}

resource "aws_subnet" "Subnet1" {
  vpc_id            = aws_vpc.VPC1.id
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.60.0.0/24"
  tags = {
    Name = "IDC-VPC1-Subnet1"
  }
}

resource "aws_route_table_association" "Subnet1RouteTableAssociation" {
  route_table_id = aws_route_table.RouteTable1.id
  subnet_id      = aws_subnet.Subnet1.id
}

resource "aws_route_table" "RouteTable2" {
  vpc_id = aws_vpc.VPC1.id
  tags = {
    Name = "IDC-PrivateRT1"
  }
}

resource "aws_route" "Route2" {
  route_table_id         = aws_route_table.RouteTable2.id
  destination_cidr_block = "10.50.0.0/16"
  network_interface_id   = aws_network_interface.Instance1ENIEth0.id

  depends_on = [aws_instance.Instance1]
}

resource "aws_subnet" "Subnet2" {
  vpc_id            = aws_vpc.VPC1.id
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.60.1.0/24"
  tags = {
    Name = "IDC-VPC1-Subnet2"
  }
}

resource "aws_route_table_association" "Subnet2RouteTableAssociation" {
  route_table_id = aws_route_table.RouteTable2.id
  subnet_id      = aws_subnet.Subnet2.id
}

resource "aws_network_interface" "Instance1ENIEth0" {
  subnet_id         = aws_subnet.Subnet1.id
  description       = "Instance1 eth0"
  security_groups   = [aws_security_group.SG1.id]
  private_ip        = "10.60.0.100"
  source_dest_check = false
  tags = {
    Name = "IDC-CGW eth0"
  }
}

resource "aws_eip" "VPCEIP1" {
  domain = "vpc"
}

resource "aws_eip_association" "VPCAssociateEIP1" {
  allocation_id        = aws_eip.VPCEIP1.allocation_id
  network_interface_id = aws_network_interface.Instance1ENIEth0.id
}

resource "aws_vpn_gateway" "VPC2VPNGW" {
  tags = {
    Name = "AWS-VPNGW"
  }
}

resource "aws_vpn_gateway_attachment" "VPC2AttachVPNGW" {
  vpc_id         = aws_vpc.VPC2.id
  vpn_gateway_id = aws_vpn_gateway.VPC2VPNGW.id
}

resource "aws_customer_gateway" "VPC2CGW" {
  type       = "ipsec.1"
  bgp_asn    = 65000
  ip_address = aws_eip.VPCEIP1.public_ip

  tags = {
    Name = "IDC-VPN-CGW"
  }

  depends_on = [aws_eip.VPCEIP1]
}

resource "aws_route_table" "VPCAWSSubnetRouteTable" {
  vpc_id = aws_vpc.VPC2.id
  tags = {
    Name = "AWS-PublicRT"
  }
}

resource "aws_route" "VPCAWSInternetRoute" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.InternetGateway2.id
  route_table_id         = aws_route_table.VPCAWSSubnetRouteTable.id

  depends_on = [aws_internet_gateway.InternetGateway2]
}

resource "aws_subnet" "VPCAWSSubnet" {
  vpc_id            = aws_vpc.VPC2.id
  cidr_block        = "10.50.1.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "AWS-VPC2-Subnet"
  }
}

resource "aws_route_table_association" "VPCAWSSubnetRouteTableAssociation" {
  route_table_id = aws_route_table.VPCAWSSubnetRouteTable.id
  subnet_id      = aws_subnet.VPCAWSSubnet.id
}

resource "aws_vpn_connection" "VPCAWSVpnConnection" {
  type                  = "ipsec.1"
  static_routes_only    = true
  customer_gateway_id   = aws_customer_gateway.VPC2CGW.id
  vpn_gateway_id        = aws_vpn_gateway.VPC2VPNGW.id
  tunnel1_preshared_key = var.preshared_key

  tags = {
    Name = "AWS-VPNConnection-IDC"
  }
}

resource "aws_vpn_connection_route" "VPCAWSVpnConnectionRoute" {
  destination_cidr_block = "10.60.0.0/16"
  vpn_connection_id      = aws_vpn_connection.VPCAWSVpnConnection.id
}

resource "aws_vpn_gateway_route_propagation" "VPNAWSGatewayRoutePropagation" {
  route_table_id = aws_route_table.VPCAWSSubnetRouteTable.id
  vpn_gateway_id = aws_vpn_gateway.VPC2VPNGW.id

  depends_on = [aws_vpn_connection.VPCAWSVpnConnection]
}