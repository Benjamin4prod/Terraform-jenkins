
resource "aws_s3_bucket" "s3_bucket" {
    bucket = "${var.s3_bucket_name}-2023"
    acl    = "private"

    versioning {
        enabled = true
     }

    tags = {
        name = "{${var.s3_bucket_name}}"
        environment = var.environment
        terraform = "true"

    }
}