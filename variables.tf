output "first" {
  value = "this is atest variable"
}

output "server-1_domainName" {
  value = "${aws_instance.server-1.public_dns}"
}
