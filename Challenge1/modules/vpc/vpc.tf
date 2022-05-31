# Creating the VPC
resource "aws_vpc" "app-vpc" {
  cidr_block = var.cidr
  tags = {
    Name = var.name
  }
}

# Public Subnet in AZ1
resource "aws_subnet" "app-subnet-public-az1" {
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "app-subnet-public-az1"
  }
}

# Private Subnet in AZ1
resource "aws_subnet" "app-subnet-private-az1" {
  vpc_id            = aws_vpc.app-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "app-subnet-private-az1"
  }
}

# Public Subnet in AZ2
resource "aws_subnet" "app-subnet-public-az2" {
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true


  tags = {
    Name = "app-subnet-public-az2"
  }
}

# Private Subnet in AZ2
resource "aws_subnet" "app-subnet-private-az2" {
  vpc_id            = aws_vpc.app-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "app-subnet-private-az2"
  }
}

# Database Subnet group
resource "aws_db_subnet_group" "db-subnet-private" {
  name       = "main"
  subnet_ids = [aws_subnet.app-subnet-private-az1.id, aws_subnet.app-subnet-private-az2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "app-igw" {
  vpc_id = aws_vpc.app-vpc.id

  tags = {
    Name = "app-igw"
  }
}

# Elastic IP
resource "aws_eip" "app-eip-az1" {
  vpc = true
}

# Elastic IP
resource "aws_eip" "app-eip-az2" {
  vpc = true
}

# NAT Gateway in AZ1
resource "aws_nat_gateway" "app-ngw-az1" {
  allocation_id = aws_eip.app-eip-az1.id
  subnet_id     = aws_subnet.app-subnet-public-az1.id

  depends_on = [aws_internet_gateway.app-igw]

  tags = {
    Name = "app-ngw-az1"
  }
}

# NAT Gateway in AZ2
resource "aws_nat_gateway" "app-ngw-az2" {
  allocation_id = aws_eip.app-eip-az2.id
  subnet_id     = aws_subnet.app-subnet-public-az2.id

  depends_on = [aws_internet_gateway.app-igw]

  tags = {
    Name = "app-ngw-az2"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "app-rt-public" {
  vpc_id = aws_vpc.app-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app-igw.id
  }

  tags = {
    Name = "app-rt-public"
  }
}

# Route Table for Private Subnet in AZ1
resource "aws_route_table" "app-rt-private-az1" {
  vpc_id = aws_vpc.app-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.app-ngw-az1.id
  }

  tags = {
    Name = "app-rt-private-az1"
  }
}

# Route Table for Private Subnet in AZ2
resource "aws_route_table" "app-rt-private-az2" {
  vpc_id = aws_vpc.app-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.app-ngw-az2.id
  }

  tags = {
    Name = "app-rt-private-az2"
  }
}

# Associating Public Route Table to Public Subnet in AZ1
resource "aws_route_table_association" "app-rt-public-az1" {
  subnet_id      = aws_subnet.app-subnet-public-az1.id
  route_table_id = aws_route_table.app-rt-public.id

  depends_on = [aws_subnet.app-subnet-public-az1]
}

# Associating Private Route Table to Public Subnet in AZ2
resource "aws_route_table_association" "app-rt-public-az2" {
  subnet_id      = aws_subnet.app-subnet-public-az2.id
  route_table_id = aws_route_table.app-rt-public.id
  depends_on     = [aws_subnet.app-subnet-public-az2]
}

# Associating Private Route Table to Private Subnet in AZ1
resource "aws_route_table_association" "app-rt-private-az1" {
  subnet_id      = aws_subnet.app-subnet-private-az1.id
  route_table_id = aws_route_table.app-rt-private-az1.id
  depends_on     = [aws_subnet.app-subnet-private-az1]
}

# Associating Private Route Table to Private Subnet in AZ2
resource "aws_route_table_association" "app-rt-private-az2" {
  subnet_id      = aws_subnet.app-subnet-private-az2.id
  route_table_id = aws_route_table.app-rt-private-az2.id
  depends_on     = [aws_subnet.app-subnet-private-az2]
}

