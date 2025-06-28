resource "aws_vpc" "ou-vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.ou-vpc.id
    cidr_block = var.public_subnets[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = true

    tags = {
      Name = "public-subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.ou-vpc.id
    cidr_block = var.private_subnets[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
      Name = "private-subnet-${count.index + 1}"
    }
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ou-vpc.id

  tags = {
    Name = "igw-${var.vpc_name}"
  }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.ou-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "public-rt"
    }
}

resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
    domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public[0].id

    tags = {
        Name = "nat-gw"
    }

    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.ou-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }

    tags = {
      Name = "private-rt"
    }
}

resource "aws_route_table_association" "private" {
    count = length(aws_subnet.private)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
}