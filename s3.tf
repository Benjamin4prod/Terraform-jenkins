
resource "aws_s3_bucket" "s3_bucket" {
    bucket = "${var.s3_bucket_name}-2023"
    tags = {
        name = "{${var.s3_bucket_name}}"
        environment = var.environment
        terraform = "true"

    }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  acl    = "private"
}