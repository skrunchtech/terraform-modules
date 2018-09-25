output "vpc_id" {
  description = "VPC ID"
  value       = "${element(concat(aws_vpc.this.*.id, list("")), 0)}"
}

output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = "${element(concat(aws_vpc.this.*.cidr_block, list("")), 0)}"
}

output "default_network_acl_id" {
  description = "Default network ACL ID"
  value       = "${element(concat(aws_vpc.this.*.default_network_acl_id, list("")), 0)}"
}

output "default_security_group_id" {
  description = "Default security group ID (created by default on VPC creation)"
  value       = "${element(concat(aws_vpc.this.*.default_security_group_id, list("")), 0)}"
}

output "default_route_table_id" {
  description = "Default route table ID"
  value       = "${element(concat(aws_vpc.this.*.default_route_table_id, list("")), 0)}"
}

output "vpc_route_table_id" {
  description = "Route table ID associated with this VPC"
  value       = "${element(concat(aws_vpc.this.*.main_route_table_id, list("")), 0)}"
}

output "public_subnets" {
  description = "Public Subnets IDs"
  value       = ["${aws_subnet.public_subnets.*.id}"]
}

output "public_subnets_cidr_blocks" {
  description = "Public Subnets CIDR Blocks list"
  value       = ["${aws_subnet.public_subnets.*.cidr_block}"]
}

output "public_route_table_ids" {
  description = "Public Route Table IDs"
  value       = ["${aws_route_table.public-route-table.*.id}"]
}

output "igw_id" {
  description = "Internet Gateway IDs"
  value       = "${element(concat(aws_internet_gateway.internet-gateway.*.id, list("")), 0)}"
}
