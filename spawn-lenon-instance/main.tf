module "security-group"{
  source = "../security-group",
  sgname = "${var.sgname}",
  sgdescription = "${var.sgdescription}"
}
resource "aws_security_group_rule" "rule1" {
  security_group_id = "${module.security-group.security-group-id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
}

resource "aws_security_group_rule" "rule2" {
  security_group_id = "${module.security-group.security-group-id}"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
}
resource "aws_security_group_rule" "rule3" {
  security_group_id = "${module.security-group.security-group-id}"
  from_port         = 8090
  to_port           = 8090
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
}
resource "aws_security_group_rule" "rule4" {
  security_group_id = "${module.security-group.security-group-id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
}

module "lenon-instance" {
  source = "../instance",
  ami="${var.ami}",
  key_name="${var.key_name}",
  s3cfgFile="${var.s3cfgFile}",
  cfgdestination="${var.cfgdestination}",
  user="${var.user}",
  key="${var.key}",
  inlineparams="${var.inlineparams}",
  sgid="${module.security-group.security-group-id}",
  instance_type="${var.instance_type}"
}


output "ip" {
  value = "${module.lenon-instance.ip}"
}
