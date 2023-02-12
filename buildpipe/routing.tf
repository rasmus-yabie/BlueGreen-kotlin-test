
#
# Public network part
#
resource "aws_route_table" "build_public" {
  vpc_id = aws_vpc.build.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.build_inet_gwy.id
  }
  tags = {
    Name = "Public net build rtr"
  }
}

# resource "aws_route" "build_public" {
#   route_table_id         = aws_route_table.build_public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.build_inet_gwy.id
# }

resource "aws_route_table_association" "build_public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.build_public.*.id, count.index)
  route_table_id = aws_route_table.build_public.id
}


#
# Private network
#
resource "aws_route_table" "build_private" {
  vpc_id = aws_vpc.build.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.build_nat_gwy.id
  }
  tags = {
    Name = "Private net build rtr"
  }
}

resource "aws_nat_gateway" "build_nat_gwy" {
  allocation_id = aws_eip.build_nat_gwy.id
  subnet_id     = aws_subnet.build_public.1.id
  depends_on    = [aws_internet_gateway.build_inet_gwy]
  tags = {
    Name = "NAT build Gwy"
  }
}

resource "aws_eip" "build_nat_gwy" {
  vpc = true
}


resource "aws_route_table_association" "build_private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.build_private.*.id, count.index)
  route_table_id = aws_route_table.build_private.id
}
