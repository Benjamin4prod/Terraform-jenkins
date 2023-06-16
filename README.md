# Terraform-jenkins
Prerequisites:

1. An AWS account with IAM user access.
2. AWS CLI configured with credentials.
3. AN s3 bucket to store State and Dynamodb table to lock state when needed.


This repo contains a ci/cd pipeline to automatically deploy infrastructure on AWS. See attached below the flow of action for infrastructure creation.
![image](https://github.com/Benjamin4prod/Terraform-jenkins/assets/136221097/5a4bf5cb-6986-4693-90ff-0f0d4ca977f5)

The jenkinsfile creates a parameterized pipeline to either apply or destroy terraform infrastructure. Once the new terraform modules are merged to the main braanch, Jenkins is automatically triggered to create/update the infrastrcture. See below the pipeline.
