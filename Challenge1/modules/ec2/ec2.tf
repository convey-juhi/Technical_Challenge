# Create key pair
resource "aws_key_pair" "ec2-keypair" {
  key_name   = "ec2-keypair"
  public_key = var.public-key
}

# Fetch the data about the AWS ami based on filters from AWS Management Console for Web Instances
data "aws_ami" "web-ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Creates a Launch Template for EC2 instances in Web Tier
resource "aws_launch_template" "web-lt" {
  name_prefix            = "web-lt"
  image_id               = data.aws_ami.web-ami.id
  instance_type          = var.web_instance_type
  vpc_security_group_ids = [var.web_tier_sg]
  key_name               = aws_key_pair.ec2-keypair.key_name

  tags = {
    Name = var.web_name
  }
}

# Creates an AutoScaling Group for EC2 instances in Web Tier
resource "aws_autoscaling_group" "web-asg" {
  desired_capacity          = 2
  max_size                  = 10
  min_size                  = 2
  vpc_zone_identifier       = var.web_subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.web-lt.id
    version = "$Latest"
  }
}

# Fetch the data about the AWS ami based on filters from AWS Management Console for App Instances
data "aws_ami" "app-ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Creates a Launch Template for EC2 instances in App Tier
resource "aws_launch_template" "app-lt" {
  name_prefix            = "app-lt"
  image_id               = data.aws_ami.app-ami.id
  instance_type          = var.app_instance_type
  vpc_security_group_ids = [var.app_tier_sg]
  key_name               = aws_key_pair.ec2-keypair.key_name

  tags = {
    Name = var.app_name
  }
}

# Creates an AutoScaling Group for EC2 instances in App Tier
resource "aws_autoscaling_group" "app-asg" {
  desired_capacity          = 2
  max_size                  = 10
  min_size                  = 2
  vpc_zone_identifier       = var.app_subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.app-lt.id
    version = "$Latest"
  }
}


