resource "aws_sagemaker_notebook_instance" "notebook_instance" {
  name                   = "example-notebook-instance-${var.student_name}"
  role_arn               = aws_iam_role.notebook_role.arn
  instance_type          = "ml.t2.medium"
  direct_internet_access = "Disabled"
  subnet_id              = aws_subnet.main.id
  security_groups        = [aws_security_group.allow_tls.id]
}

output "notebook_url" {
  value = aws_sagemaker_notebook_instance.notebook_instance.url
}

resource "aws_s3_bucket" "notebook_bucket" {
  bucket = "better-infrastructure-management-with-terraform-${var.student_name}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "notebook_bucket_policy" {
  bucket = aws_s3_bucket.notebook_bucket.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*Object"
        Resource = [
          aws_s3_bucket.notebook_bucket.arn,
          "${aws_s3_bucket.notebook_bucket.arn}/*",
        ]
        Condition = {
          NotIpAddress = {
            "aws:SourceIp" = aws_subnet.main.cidr_block
          }
        }
      },
    ]
  })
}
