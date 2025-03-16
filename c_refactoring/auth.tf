variable "student_name" {
  type = string
}

resource "aws_iam_role" "notebook_role" {
  name = "sagemaker_notebook_role-${var.student_name}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = []

  inline_policy {
    name = "S3_access"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["s3:ListAllMyBuckets", "s3:ListBucket", "s3:HeadBucket"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "80"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}