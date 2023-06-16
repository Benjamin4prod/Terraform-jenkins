resource "aws_iam_role" "Jenkins_s3_role" {
    name = var.iam_role_name
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "jenkins_s3_policy" {
  name        = var.iam_policy_name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_iam_policy_attachment" "jenkins_s3_policy" {
  roles = aws_iam_role.Jenkins_s3_role.name
  policy_arn = aws_iam_policy.jenkins_s3_policy.arn

}