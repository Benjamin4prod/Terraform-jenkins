#s3 vars
#variable "s3_bucket_name" {
 # type = string
  #description = "name of s3bucket"]
  
#}
#---------------------------------------------
#vpc vars

variable "vpc_name" {
  type = string
  description = "Name of VPC"
  default = "Ben_prod"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block of VPC"
  default = "101.0.0.0/16"
}

variable "enable_dns_hostnames" {
  type = bool
  description = "Enabling dns hostnames"
  default = true
}

variable "environment" {
  type = string
  description = "NAME OF ENVIRONMENT"
  default = "prod"
}
variable "all_ipv4" {
  type = string
  default = "0.0.0.0/0"
}
variable "private_subnets" {
  default = {
    "private-1" = 0
    "private-2" = 1
  }
}

variable "public_subnets" {
  default = {
    "public-1" = 0
    "public-2" = 1
  }
}
#--------------------------------------------------------
#ec2 vars

variable "ssh_location" {
  type = string
  description = "my IP adress"
  default = "YOUR_PUBLIC_IPV4_ADRESS/32"
}

variable "jenkins_ec2_name" {
  type = string
  description = "Name of jenkins server"
  default = "Jenkins_server"
}

variable "jenkins_ec2_ami" {
  type = string
  description = "Jenkins server ami"
}

variable "jenkins_ec2_type" {
  type = string
  description = "Ec2 instance type for jenkins server"
  default = "t3.micro"
}

variable "user_data" {
  type = string
  description = "User data file name"
  default = "jenkins_bootstrap.sh"
}

variable "key_pair" {
  type = string
  description = "name of instance key pair"
  default = "jenkins_keypair.pem"
}

variable "jenkins_ec2_instance_profile_name" {
  type = string
  description = "jenkins ec2 instance profile name"
  default = "jenkins_s3_instance_profile"
}

#---------------------------------------------------------
# iam vars

variable "iam_role_name" {
    type = string
    description = "iam role for jenkins ec2"
    default = "jenkins_s3_role"
}

variable "iam_policy_name" {
  type = string
  description = "Iam policy name"
  default = "jenkins_s3_policy"
}

variable "s3_actions" {
    type = list(string)
    description = "actions allowed by jenkins server"
    default = [
        "s3:fullaccess",
        "dyanmodb:fullaccess"
    ]
}

variable "iam_resource_type" {
  type = string
  description = "Iam policy resource type"
  default = "arn:aws:s3:::"
}
