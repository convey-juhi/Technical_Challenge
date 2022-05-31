# Security Group for web-lb (External) loadbalancer
resource "aws_security_group" "web-lb-sg" {
  name        = "web-lb-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.app-vpc.id

  ingress {
    description = "TLS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Internet to web LB"
  }
}

# Security Group for ec2 instances in web-tier
resource "aws_security_group" "web-tier-sg" {
  name        = "web-tier-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.app-vpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [aws_vpc.app-vpc.cidr_block]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = [aws_vpc.app-vpc.cidr_block]
  }

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = [aws_vpc.app-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Application LB to Web-Tier EC2 instances"
  }
}

# Security Group for App-Tier EC2 instances
resource "aws_security_group" "app-tier-sg" {
  name        = "app-tier-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.app-vpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [aws_vpc.app-vpc.cidr_block]
  }

  ingress {
    description = "TCP from VPC"
    from_port   = 3000
    to_port     = 3000
    protocol    = "TCP"
    cidr_blocks = [aws_vpc.app-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Application LB to Web-Tier EC2 instances"
  }
}

# Security Group for Database
resource "aws_security_group" "database-sg" {
  name        = "database-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.app-vpc.id

  ingress {
    description = "TCP from AZ1 Private Subnet"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = [aws_subnet.app-subnet-private-az1.cidr_block]
  }

  ingress {
    description = "TCP from AZ1 Private Subnet"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = [aws_subnet.app-subnet-private-az2.cidr_block]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Application LB to Web-Tier EC2 instances"
  }
}