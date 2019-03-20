resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "terraform-aws-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block,8,1)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${data.aws_availability_zones.av_zone.names[0]}"
}

resource "aws_subnet" "subnet2" {
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block,8,2)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${data.aws_availability_zones.av_zone.names[1]}"
}

resource "aws_security_group" "vpc_security_group" {
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    cidr_blocks = [
      "${aws_vpc.vpc.cidr_block}",
    ]

    from_port = 80
    protocol  = "tcp"
    to_port   = 80
  }
}
