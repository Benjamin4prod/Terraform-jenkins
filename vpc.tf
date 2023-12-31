# Retrieve AZs
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name        = "${var.vpc_name}-vpc"
    environment = var.environment
    Terraform   = "true"
  }
}
resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr_blocks
  availability_zone = var.availability_zone
  count             = length(var.public_subnets)
  
  map_public_ip_on_launch = true

  tags = {
    name        = "${var.vpc_name}_${count.index}"
    environment = var.environment
    Terraform   = true
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.private_subnets)
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 15)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    name        = "${var.vpc_name}_${count.index}"
    environment = var.environment
    Terraform   = true
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    name        = "${var.vpc_name}_igw"
    environment = var.environment
    Terraform   = "true"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = var.all_ipv4
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    name        = "${var.vpc_name}_public_rt"
    environment = var.environment
    Terraform   = "True"
  }
}

resource "aws_route_table_association" "route_table_attachment" {
  depends_on = [ aws_subnet.public_subnets ]
  count = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
  
}
