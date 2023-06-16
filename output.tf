
output "VPC_id" {
    description = "id of project vpc"
    value = aws_vpc.vpc.id
}

output "jenkins_ec2_public_ip" {
    description = "public ip of jenkins server"
    value = aws_instance.jenkins.public_ip
}

output "s3_bucket_name" {
  description = "jenkins s3 bucket name"
  value = aws_s3_bucket.s3_bucket.bucket
}

output "s3_bucket_arn" {
  description = "arn of s3 bucket"
  value = aws_s3_bucket.s3_bucket.arn
}