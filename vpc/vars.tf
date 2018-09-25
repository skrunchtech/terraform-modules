/*
Module variables
*/


variable "env" {
  description = "Environment that is serviced by this VPC"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  description = "List of Public Subnets"
  type = "list"
}
variable "vpc_name" {
  description = "VPC Name for tags and identification"
}

variable "azs" {
  description = "List of AZs to be used for the subnets"
  type = "list"
}

variable "map_public_ip_on_launch" {
  description = "Assign public IP by default to instances launched"
  default = false
}