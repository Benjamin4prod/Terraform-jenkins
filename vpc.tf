#retrieve azs
data "aws_availability_zone" "Avaialable" {}
data "aws_region" "current" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.vpc_name}-vpc"
    environment = "var.environment"
    Terraform = "true"
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.vpc.id
  for_each = var.public_subnets
  cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value+15)
  availability_zone = tolist(data.aws_availability_zone.Avaialable.name)[each.value]

  map_public_ip_on_launch = var.all_ipv4

  tags = {
    name = "${var.vpc_name}_${each_key + 1}"
    environment = var.environment
    Terraform = true
  }
}

esource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.vpc.id
  for_each = var.private_subnets
  cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value+15)
  availability_zone = tolist(data.aws_availability_zone.Avaialable.name)[each.value]

  map_public_ip_on_launch = var.all_ipv4

  tags = {
    name = "${var.vpc_name}_${each_key + 1}"
    environment = var.environment
    Terraform = true
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    name = "${var.vpc_name}_igw"
    environment = var.environment
    Terraform = "true"
  }
}

resource "aws_default_route_table" "public_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = var.all_ipv4
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    name = "${var.vpc_name}_public_rt"
    environment = var.environment
    Terraform = "True"
  }
}

resource "aws_route_table_association" "route_table_attachment" {
depends_on = [ aws_subnet.public_subnets ]
route_route_table_id = aws_default_route_table_id.public_route_table.id
for_each = aws_subnet.public_subnets
subnet_id = each.value.id
}

