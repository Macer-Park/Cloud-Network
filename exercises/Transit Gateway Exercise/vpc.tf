resource "aws_vpc" "VPC0" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "TGW-VPC0"
  }
}

resource "aws_internet_gateway" "VPC0InternetGateway" {
  tags = {
    Name = "TGW-VPC0-IGW"
  }
}

resource "aws_internet_gateway_attachment" "VPC0InternetGatewayAttachment" {
  internet_gateway_id = aws_internet_gateway.VPC0InternetGateway.id
  vpc_id              = aws_vpc.VPC0.id
}

resource "aws_route_table" "VPC0RouteTable1" {
  vpc_id = aws_vpc.VPC0.id
  tags = {
    Name = "TGW-VPC0-PublicRT"
  }
}

resource "aws_route_table" "VPC0RouteTable2" {
  vpc_id = aws_vpc.VPC0.id
  tags = {
    Name = "TGW-VPC0-TGWAttachRT"
  }
}

resource "aws_route" "VPC0Route1" {
  route_table_id         = aws_route_table.VPC0RouteTable1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.VPC0InternetGateway.id

  depends_on = [aws_internet_gateway_attachment.VPC0InternetGatewayAttachment]
}

resource "aws_subnet" "VPC0Subnet1" {
  vpc_id                  = aws_vpc.VPC0.id
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true
  cidr_block              = "10.0.1.0/24"
  tags = {
    Name = "TGW-VPC0-Subnet1"
  }
}

resource "aws_route_table_association" "VPC0Subnet1RouteTableAssociation" {
  route_table_id = aws_route_table.VPC0RouteTable1.id
  subnet_id      = aws_subnet.VPC0Subnet1.id
}

resource "aws_subnet" "VPC0Subnet2" {
  vpc_id                  = aws_vpc.VPC0.id
  availability_zone       = "ap-northeast-2b"
  map_public_ip_on_launch = true
  cidr_block              = "10.0.2.0/24"
  tags = {
    Name = "TGW-VPC0-Subnet2"
  }
}

resource "aws_route_table_association" "VPC0Subnet2RouteTableAssociation" {
  route_table_id = aws_route_table.VPC0RouteTable1.id
  subnet_id      = aws_subnet.VPC0Subnet2.id
}

resource "aws_subnet" "VPC0Subnet3" {
  vpc_id            = aws_vpc.VPC0.id
  availability_zone = "ap-northeast-2c"
  cidr_block        = "10.0.3.0/24"
  tags = {
    Name = "TGW-VPC0-Subnet3"
  }
}

resource "aws_route_table_association" "VPC0Subnet3RouteTableAssociation" {
  route_table_id = aws_route_table.VPC0RouteTable2.id
  subnet_id      = aws_subnet.VPC0Subnet3.id
}

resource "aws_subnet" "VPC0Subnet4" {
  vpc_id            = aws_vpc.VPC0.id
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.0.4.0/24"
  tags = {
    Name = "TGW-VPC0-Subnet4"
  }
}

resource "aws_route_table_association" "VPC0Subnet4RouteTableAssociation" {
  route_table_id = aws_route_table.VPC0RouteTable2.id
  subnet_id      = aws_subnet.VPC0Subnet4.id
}

resource "aws_vpc_endpoint" "VPC0Endpoint1" {
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.VPC0SG2.id]
  service_name        = "com.amazonaws.ap-northeast-2.cloudformation"
  subnet_ids          = [aws_subnet.VPC0Subnet1.id, aws_subnet.VPC0Subnet2.id]
  vpc_id              = aws_vpc.VPC0.id
  vpc_endpoint_type   = "Interface"
}

resource "aws_vpc" "VPC1" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "TGW-VPC1"
  }
}

resource "aws_route_table" "VPC1RouteTable1" {
  vpc_id = aws_vpc.VPC1.id
  tags = {
    Name = "TGW-VPC1-PrivateRT"
  }
}

resource "aws_route_table" "VPC1RouteTable2" {
  vpc_id = aws_vpc.VPC1.id
  tags = {
    Name = "TGW-VPC1-TGWAttachRT"
  }
}

resource "aws_subnet" "VPC1Subnet1" {
  vpc_id            = aws_vpc.VPC1.id
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.10.1.0/24"

  tags = {
    Name = "TGW-VPC1-Subnet1"
  }
}

resource "aws_route_table_association" "VPC1Subnet1RouteTableAssociation" {
  route_table_id = aws_route_table.VPC1RouteTable1.id
  subnet_id      = aws_subnet.VPC1Subnet1.id
}

resource "aws_subnet" "VPC1Subnet2" {
  vpc_id            = aws_vpc.VPC1.id
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.10.2.0/24"
  tags = {
    Name = "TGW-VPC1-Subnet2"
  }
}

resource "aws_route_table_association" "VPC1Subnet2RouteTableAssociation" {
  route_table_id = aws_route_table.VPC1RouteTable1.id
  subnet_id      = aws_subnet.VPC1Subnet2.id
}

resource "aws_subnet" "VPC1Subnet3" {
  vpc_id            = aws_vpc.VPC1.id
  availability_zone = "ap-northeast-2c"
  cidr_block        = "10.10.3.0/24"

  tags = {
    Name = "TGW-VPC1-Subnet3"
  }
}

resource "aws_route_table_association" "VPC1Subnet3RouteTableAssociation" {
  route_table_id = aws_route_table.VPC1RouteTable2.id
  subnet_id      = aws_subnet.VPC1Subnet3.id
}

resource "aws_subnet" "VPC1Subnet4" {
  vpc_id            = aws_vpc.VPC1.id
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.10.4.0/24"

  tags = {
    Name = "TGW-VPC1-Subnet4"
  }
}

resource "aws_route_table_association" "VPC1Subnet4RouteTableAssociation" {
  route_table_id = aws_route_table.VPC1RouteTable2.id
  subnet_id      = aws_subnet.VPC1Subnet4.id
}

resource "aws_vpc" "VPC2" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "TGW-VPC2"
  }
}

resource "aws_route_table" "VPC2RouteTable1" {
  vpc_id = aws_vpc.VPC2.id
  tags = {
    Name = "TGW-VPC2-PrivateRT"
  }
}

resource "aws_route_table" "VPC2RouteTable2" {
  vpc_id = aws_vpc.VPC2.id
  tags = {
    Name = "TGW-VPC2-TGWAttachRT"
  }
}

resource "aws_subnet" "VPC2Subnet1" {
  vpc_id            = aws_vpc.VPC2.id
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.20.1.0/24"

  tags = {
    Name = "TGW-VPC2-Subnet1"
  }
}

resource "aws_route_table_association" "VPC2Subnet1RouteTableAssociation" {
  route_table_id = aws_route_table.VPC2RouteTable1.id
  subnet_id      = aws_subnet.VPC2Subnet1.id
}

resource "aws_subnet" "VPC2Subnet2" {
  vpc_id            = aws_vpc.VPC2.id
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.20.2.0/24"

  tags = {
    Name = "TGW-VPC2-Subnet2"
  }
}

resource "aws_route_table_association" "VPC2Subnet2RouteTableAssociation" {
  route_table_id = aws_route_table.VPC2RouteTable1.id
  subnet_id      = aws_subnet.VPC2Subnet2.id
}

resource "aws_subnet" "VPC2Subnet3" {
  vpc_id            = aws_vpc.VPC2.id
  availability_zone = "ap-northeast-2c"
  cidr_block        = "10.20.3.0/24"

  tags = {
    Name = "TGW-VPC2-Subnet3"
  }
}

resource "aws_route_table_association" "VPC2Subnet3RouteTableAssociation" {
  route_table_id = aws_route_table.VPC2RouteTable2.id
  subnet_id      = aws_subnet.VPC2Subnet3.id
}

resource "aws_subnet" "VPC2Subnet4" {
  vpc_id            = aws_vpc.VPC2.id
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.20.4.0/24"

  tags = {
    Name = "TGW-VPC2-Subnet4"
  }
}

resource "aws_route_table_association" "VPC2Subnet4RouteTableAssociation" {
  route_table_id = aws_route_table.VPC2RouteTable2.id
  subnet_id      = aws_subnet.VPC2Subnet4.id
}

resource "aws_route" "VPC0Route2" {
  route_table_id         = aws_route_table.VPC0RouteTable1.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway.TransitGateway1.id

  depends_on = [aws_ec2_transit_gateway.TransitGateway1]
}

resource "aws_route" "VPC1Route2" {
  route_table_id         = aws_route_table.VPC1RouteTable1.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway.TransitGateway1.id

  depends_on = [aws_ec2_transit_gateway.TransitGateway1]
}

resource "aws_route" "VPC2Route2" {
  route_table_id         = aws_route_table.VPC2RouteTable1.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway.TransitGateway1.id

  depends_on = [aws_ec2_transit_gateway.TransitGateway1]
}