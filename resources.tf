resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "terraform-aws-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  cidr_block              = "${cidrsubnet(aws_vpc.vpc.cidr_block,8,1)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.av_zone.names[0]}"
}

resource "aws_subnet" "subnet2" {
  cidr_block              = "${cidrsubnet(aws_vpc.vpc.cidr_block,8,2)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.av_zone.names[1]}"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "mozufferfirstbacket"
}

resource "aws_iam_policy" "my_bucket_policy" {
  name = "my-first-bucket-policy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
      {
         "Action": [
            "s3:ListAllMyBuckets"
         ],
         "Effect": "Allow",
         "Resource": [
            "${aws_s3_bucket.my_bucket.arn}"
         ]
       }
    ]
  }
POLICY
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

  ingress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]

    from_port = 22
    protocol  = "tcp"
    to_port   = 22
  }
}
