
resource "aws_s3_bucket" "s3_bucket" {
    bucket = "${var.s3-name}-2023"
    acl    = "private"

    versioning {
        enabled = true
     }

    tags = {
        name = "{${var.s3_bucket}}"
        environment = var.environment
        terraform = "true"

    }
}