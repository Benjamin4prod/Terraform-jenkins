terraform {
  backend "s3" {
    bucket = "tf-state-ben-dev-2"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "terraform_state_lock"
  }
}
