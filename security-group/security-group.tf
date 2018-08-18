
resource "aws_security_group" "securitygroup" {
  name        = "${var.sgname}"
  description = "${var.sgdescription}"
}

output "security-group-id" {
  value = "${aws_security_group.securitygroup.id}"
}
