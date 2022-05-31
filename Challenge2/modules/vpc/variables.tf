#VPC Module Variables

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "app-vpc"
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

