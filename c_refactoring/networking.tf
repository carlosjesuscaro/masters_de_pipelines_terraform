resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/28"
  map_public_ip_on_launch = false
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.main.id
  service_name    = "com.amazonaws.eu-west-1.s3"
  route_table_ids = [aws_route_table.main.id]
}

resource "aws_vpc_endpoint" "sagemaker_notebook" {
  vpc_id              = aws_vpc.main.id
  service_name        = "aws.sagemaker.eu-west-1.notebook"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.allow_tls.id]
  subnet_ids          = [aws_subnet.main.id]
}


resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}