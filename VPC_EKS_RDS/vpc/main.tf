resource "aws_vpc" "main" {

  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
    Name        = "${var.environment}_${var.group_id}"
    environment = "${var.environment}"
    group_id   = "${var.group_id}"
  }
}



resource "aws_subnet" "main" {
  count = "${length(var.subnet_cidr)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.subnet_cidr, count.index)}"
  availability_zone = "${element(var.availability_zone, count.index)}"

  tags {
    Name        = "${var.environment}_${var.group_id}"
    environment = "${var.environment}"
    group_id   = "${var.group_id}"
  }
}


resource "aws_eip" "natgw" {
  count = "${length(var.subnet_cidr)}"
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  count = "${length(var.subnet_cidr)}"

  allocation_id = "${element(aws_eip.natgw.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.main.*.id, count.index)}"
    tags {
    Name        = "${var.environment}_${var.group_id}"
    environment = "${var.environment}"
    group_id   = "${var.group_id}"
  }
}


resource "aws_route_table" "route" {
  count = "${length(var.subnet_cidr)}"
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.natgw.*.id, count.index)}"
  }

tags {
    Name        = "${var.environment}_${var.group_id}"
    environment = "${var.environment}"
    group_id   = "${var.group_id}"
  }
}


resource "aws_route_table_association" "subnet_public" {
  count = "${length(var.subnet_cidr)}"
  subnet_id      = "${element(aws_subnet.main.*.id, count.index)}"
  route_table_id = "${aws_route_table.route.id}"
}

