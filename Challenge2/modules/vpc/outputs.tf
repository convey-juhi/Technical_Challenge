output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.app-vpc.id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.app-vpc.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.app-vpc.cidr_block
}

output "app-subnet-private-az1" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.app-subnet-private-az1.id
}

output "app-subnet-private-az1_arn" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.app-subnet-private-az1.arn
}

output "app-subnet-private-az1_cidr_block" {
  description = "List of cidr_blocks of private subnets"
  value       = aws_subnet.app-subnet-private-az1.cidr_block
}

output "app-subnet-private-az2" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.app-subnet-private-az2.id
}

output "app-subnet-private-az2_arn" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.app-subnet-private-az2.arn
}

output "app-subnet-private-az2_cidr_block" {
  description = "List of cidr_blocks of private subnets"
  value       = aws_subnet.app-subnet-private-az2.cidr_block
}

output "app-subnet-public-az1" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.app-subnet-public-az1.id
}

output "app-subnet-public-az1_arn" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.app-subnet-public-az1.arn
}

output "app-subnet-public-az1_cidr_block" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_subnet.app-subnet-public-az1.cidr_block
}

output "app-subnet-public-az2" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.app-subnet-public-az2.id
}

output "app-subnet-public-az2_arn" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.app-subnet-public-az2.arn
}

output "app-subnet-public-az2_cidr_block" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_subnet.app-subnet-public-az2.cidr_block
}

output "db_subnet_group" {
  description = "List of subnet IDs for Database"
  value       = aws_db_subnet_group.db-subnet-private.id
}

output "web-lb-sg-id" {
  description = "Security Group to be attached to the Web Loadbalancer"
  value       = aws_security_group.web-lb-sg.id
}

output "web-tier-sg-id" {
  description = "Security Group to be attached to the EC2 instances in Web-Tier"
  value       = aws_security_group.web-tier-sg.id
}

output "app-tier-sg-id" {
  description = "Security Group to be attached to the EC2 instances in App-Tier"
  value       = aws_security_group.app-tier-sg.id
}

output "database-sg-id" {
  description = "Security Group to be attached to the Database"
  value       = aws_security_group.database-sg.id
}