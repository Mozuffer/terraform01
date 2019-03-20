resource "aws_instance" "server-1" {
  ami           = "ami-0080e4c5bc078760e"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.subnet1.id}"
  key_name      = "Mooz"

  tags {
    Name        = "server-1"
    BillingCode = "ABCD-23344"
    environment = "Dev"
  }
}
