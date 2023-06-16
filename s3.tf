resource "random_id" "s3_random_name" {
  byte_length = 5
}

resource "aws_s3_bucket" "s3_bucket" {
    count = 2
    bucket = "${var.s3-name}-${random_id.randomize.hex}"
    acl    = "private"

    versioning {
        enabled = true
     }

    tags = {
     name = {${var.s3_bucket}-${random_id.randomize.hex}}
        environment = var.environment
        terraform = "true"

    }
}