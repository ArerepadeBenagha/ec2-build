resource "aws_s3_bucket" "terraform-state-" {
  bucket = "terraform-state-689defi"
  acl    = "private"
  versioning {
    enabled = true
  }
}
resource "aws_s3_bucket" "dev-infra" {
  bucket = "my-dev-infra"
  acl    = "public-read"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "elite-infra-bucket-Dev"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_policy" "dev-infra" {
  bucket = aws_s3_bucket.dev-infra.id

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
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.dev-infra.arn,
          "${aws_s3_bucket.dev-infra.arn}/*",
        ]
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "8.8.8.8/32"
          }
        }
      },
    ]
  })
}