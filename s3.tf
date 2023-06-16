
resource "aws_s3_bucket" "s3_bucket" {
    bucket = "${var.s3_bucket_name}-2023"
    acl    = "private"

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