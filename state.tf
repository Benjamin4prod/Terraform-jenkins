terraform {
  backend "s3" {
    bucket = "tf-state-4-ben"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "terraform_state_lock"
  }
}
