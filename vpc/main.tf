## Dev AWS_VPC

resource "aws_vpc" "this" {
  cidr_block = "${var.vpc_cidr}"

  tags = "${merge(var.tags, 
    map(
     "Name", "${var.vpc_name}",
     "Terraform", true,
     "Environment", "${var.env}"
    )
  )}"
}

resource "aws_subnet" "public_subnets" {
  count             = "${length(var.public_subnets)}"
  availability_zone = "${element(var.azs, count.index)}"

  cidr_block = "${var.public_subnets[count.index]}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
  vpc_id = "${aws_vpc.this.id}"

  tags = "${merge(var.tags,
    map(
     "Name", "${var.vpc_name}-public_subnets",
     "Terraform", true,
     "Environment", "${var.env}"
    )
  )}"
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = "${aws_vpc.this.id}"

  tags = "${merge(var.tags,
    map(
      "Name", "${var.vpc_name}-gateway",
      "Terraform", true,
      "Environment", "${var.env}"
    )
  )}"
}

resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet-gateway.id}"
  }
}

resource "aws_route_table_association" "public-route-table-association" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${aws_subnet.public_subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.public-route-table.id}"
}
