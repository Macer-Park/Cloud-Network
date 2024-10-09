resource "aws_vpc" "endpoint_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "endpoint_vpc"
  }
}

resource "aws_internet_gateway" "endpoint_igw" {
  tags = {
    Name = "endpoint_igw"
  }
}

resource "aws_internet_gateway_attachment" "endpoint_igw_attachment" {
  internet_gateway_id = aws_internet_gateway.endpoint_igw.id
  vpc_id              = aws_vpc.endpoint_vpc.id
}

resource "aws_route_table" "endpoint_public_rt" {
  vpc_id = aws_vpc.endpoint_vpc.id

  tags = {
    Name = "endpoint_public_rt"
  }
}

resource "aws_route" "default_public_route" {
  route_table_id         = aws_route_table.endpoint_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.endpoint_igw.id

  depends_on = [aws_internet_gateway.endpoint_igw]
}

resource "aws_route_table" "endpoint_private_rt" {
  vpc_id = aws_vpc.endpoint_vpc.id
  tags = {
    Name = "endpoint_private_rt"
  }
}

resource "aws_subnet" "endpoint_public_sn" {
  vpc_id            = aws_vpc.endpoint_vpc.id
  availability_zone = var.availability_zone[0]
  cidr_block        = "10.0.0.0/24"

  tags = {
    Name = "endpoint_public_sn"
  }
}

resource "aws_subnet" "endpoint_private_sn" {
  vpc_id            = aws_vpc.endpoint_vpc.id
  availability_zone = var.availability_zone[1]
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "endpoint_private_sn"
  }
}

resource "aws_route_table_association" "endpoint_public_sn_rt_assoc" {
  subnet_id      = aws_subnet.endpoint_public_sn.id
  route_table_id = aws_route_table.endpoint_public_rt.id
}

resource "aws_route_table_association" "endpoint_private_sn_rt_assoc" {
  subnet_id      = aws_subnet.endpoint_private_sn.id
  route_table_id = aws_route_table.endpoint_private_rt.id
}