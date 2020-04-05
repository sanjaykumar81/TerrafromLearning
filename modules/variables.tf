variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "CIDR block for vpc"
}

variable "public_subnet_cidr" {
  default     = "10.0.1.0/24"
  description = "CIDR for our public subnet"
}

variable "private_subnet_cidr" {
  default     = "10.0.2.0/24"
  description = "CIDR for our private subnet"
}