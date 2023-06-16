resource "aws_security_group" "jenkins_security_group" {
  name        = "${var.jenkins_ec2_name}_sg"
  description = "Allow ssh and http traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "ssh traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.all_ipv4]
  }
ingress {
    description      = "http traffic"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [var.all_ipv4]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "${var.jenkins_ec2_name}_sg"
    environment = var.environment
    Terraform = "true"
  }
}

resource "aws_instance" "jenkins" {
  instance_type = var.jenkins_ec2_type
  ami = var.jenkins_ec2_ami
  subnet_id = aws_subnet.public_subnets["public_subnet_1"].id
  vpc_security_group_ids = aws_security_group.jenkins_security_group.id
  key_name = var.key_pair
  user_data = file("${path.module}/${var.user_data}")
  iam_instance_profile = aws_iam_instance_profile.jenkins_s3_instance_profile.name

  tags = {
    name = "{$var.jenkins_ec2_name}"
    environment = var.environment
    Terraform = "true"
  }
}

resource "aws_iam_instance_profile" "jenkins_s3_instance_profile" {
  name = var.jenkins_ec2_instance_profile_name
  role = aws_iam_role.jenkins_s3_role.name
}