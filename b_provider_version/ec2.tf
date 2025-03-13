# AWS Ubuntu image
data "aws_ami" "aws_linux_ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20250115"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Be very restrictive in production!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Default subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  depends_on = [aws_internet_gateway.gw]
}


# EC2 instance
resource "aws_instance" "ec2_primary" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.aws_linux_ubuntu.id
  tags = {
    Name = "primary_instance"
  }
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  depends_on = [aws_subnet.public]
  subnet_id = aws_subnet.public.id
}