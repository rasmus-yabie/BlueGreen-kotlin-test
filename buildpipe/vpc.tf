resource "aws_vpc" "build" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "build_inet_gwy" {
  vpc_id = aws_vpc.build.id
}

resource "aws_subnet" "build_private" {
  vpc_id            = aws_vpc.build.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count             = length(var.private_subnets)
}

resource "aws_subnet" "build_public" {
  vpc_id                  = aws_vpc.build.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true
}

