# main.tf

# Specify the required Terraform version
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Provider configuration
provider "aws" {
  region = "sa-east-1" # Change to your desired region
}

# Variables
variable "key_name" {
  description = "The name of the SSH key pair to associate with the EC2 instance."
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key file."
  type        = string
  default     = "/Users/macerpark/Documents/Chungyun.pub" # Set a default path or input during apply
}

# AWS Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Data source to fetch the latest Amazon Linux 2 AMI ID from SSM Parameter Store
data "aws_ssm_parameter" "latest_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Data source to get the list of Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC
resource "aws_vpc" "SaVPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "SA-VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "SaIGW" {
  vpc_id = aws_vpc.SaVPC.id

  tags = {
    Name = "SA-IGW"
  }
}

# Route Table
resource "aws_route_table" "SaPublicRT" {
  vpc_id = aws_vpc.SaVPC.id

  tags = {
    Name = "SA-Public-RT"
  }
}

# Default Public Route
resource "aws_route" "SaDefaultPublicRoute" {
  route_table_id         = aws_route_table.SaPublicRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.SaIGW.id

  depends_on = [aws_internet_gateway.SaIGW]
}

# Public Subnet
resource "aws_subnet" "SaPublicSN1" {
  vpc_id                  = aws_vpc.SaVPC.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "SA-Public-SN-1"
  }
}

# Subnet Route Table Association
resource "aws_route_table_association" "SaPublicSNRouteTableAssociation" {
  subnet_id      = aws_subnet.SaPublicSN1.id
  route_table_id = aws_route_table.SaPublicRT.id
}

# Security Group
resource "aws_security_group" "WEBSG" {
  name        = "WEBSG"
  description = "Enable HTTP access via port 80 and SSH access via port 22"
  vpc_id      = aws_vpc.SaVPC.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # Consider restricting this for security
    ipv6_cidr_blocks = []
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WEBSG"
  }
}

# EC2 Instance
resource "aws_instance" "SaEC2" {
  ami                         = data.aws_ssm_parameter.latest_ami.value
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.SaPublicSN1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.WEBSG.id]

  tags = {
    Name = "SA-EC2"
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {}))

  # Associate the SSH Key Pair using the variable
  # You must select the Key Pair with .pub properties
  key_name = aws_key_pair.deployer.key_name
}

# Output the EC2 instance public IP
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.SaEC2.public_ip
}
