# Web Tier EC2 instances
variable "web_name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = "web-instances"
}

variable "web_ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = ""
}


variable "web_subnet_ids" {
  description = "AZ to start the instance in"
  type        = list(string)
  default     = [""]
}

variable "web_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "web_user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}

# App Tier EC2 instances
variable "app_name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = "app-instances"
}

variable "app_ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = ""
}


variable "app_subnet_ids" {
  description = "AZ to start the instance in"
  type        = list(string)
  default     = [""]
}

variable "app_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  default     = null
}

variable "web_lb_sg" {
  description = "web LB Security Group"
  default     = [""]
}

variable "app_tier_sg" {
  description = "App LB Security Group"
  default     = [""]
}

variable "web_tier_sg" {
  description = "web LB Security Group"
  default     = [""]
}

variable "public-key" {
  description = "Public Key to attach to the instance"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj3GA7nHVCjWUKQb3fo8U1gSn9or3dTa8DhlG/X1lWmGYyAzx6yzxBP7NcolY6+PapHUQBF8EyOXAIhS4BtkD08Voz5MlRcszqD1M46thWnn9EYibNvVuwCiHMv0OqZqVsCNSnA601mFF4HR2R4J4yuMI8lgHvO3q+0sh72aO/3lUzf96XZp+EIhkZXDqGPWhIB1m4Qagw+xP2cXgcBD3U8dUADoDWWZddUA/ZGLpGxoyK0iBAXq/QQAiaNhKL3OTtSLo845e0mxcmuUU1mKG+ctpvSGgUV7ovQnPeEFY0arzN0Hgk94XHKTVYXl8iKUxctx14X1Xurf7G52Whv7FTzOomiVAa9miaGHxbIgVUM/OE5AVQtpTYguxyBVg1rLN2E98jVjlbB4K5MAWpRKVWoz2WaQ6t6ea2TPlYNE7A8NSXBY2wKwcO8KYPvslc8cIkXHdxwbPa91R+1fTOOAsVUmuxnVHelhLl8QTsSOxNqzP/F9yjc8+mvsK/tm8W5pk="
}