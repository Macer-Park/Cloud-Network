resource "aws_ec2_transit_gateway" "TransitGateway1" {
  tags = {
    Name = "TGW1"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "TransitGatewayAtt1" {
  vpc_id             = aws_vpc.VPC0.id
  subnet_ids         = [aws_subnet.VPC0Subnet3.id, aws_subnet.VPC0Subnet4.id]
  transit_gateway_id = aws_ec2_transit_gateway.TransitGateway1.id
  tags = {
    Name = "TGW1-ATT1-VPC0"
  }

  depends_on = [aws_vpc.VPC0]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "TransitGatewayAtt2" {
  vpc_id             = aws_vpc.VPC1.id
  subnet_ids         = [aws_subnet.VPC1Subnet3.id, aws_subnet.VPC1Subnet4.id]
  transit_gateway_id = aws_ec2_transit_gateway.TransitGateway1.id
  tags = {
    Name = "TGW1-ATT1-VPC1"
  }

  depends_on = [aws_vpc.VPC1]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "TransitGatewayAtt3" {
  vpc_id             = aws_vpc.VPC2.id
  subnet_ids         = [aws_subnet.VPC2Subnet3.id, aws_subnet.VPC2Subnet4.id]
  transit_gateway_id = aws_ec2_transit_gateway.TransitGateway1.id
  tags = {
    Name = "TGW1-ATT1-VPC2"
  }
}

resource "aws_ec2_transit_gateway_route_table" "TransitGatewayRT2" {
  tags = {
    Name = "TGW-Blue-RT"
  }

  transit_gateway_id = aws_ec2_transit_gateway.TransitGateway1.id
}

resource "aws_ec2_transit_gateway_route_table" "TransitGatewayRT3" {
  tags = {
    Name = "TGW-Red-RT"
  }

  transit_gateway_id = aws_ec2_transit_gateway.TransitGateway1.id
}