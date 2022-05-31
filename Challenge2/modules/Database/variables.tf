variable "db_subnet_ids" {
  description = "AZ to start the instance in"
  default     = [""]
}

variable "db_sg_id" {
  description = "Security Groups to attach to the DB instance"
  default     = ""
}

variable "db_password" {
  description = "Database Password"
  default     = "webapp1234512345"
  sensitive   = true
}