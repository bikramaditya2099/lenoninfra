
resource "aws_instance" "lenon" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}",
  key_name="${var.key_name}",
  vpc_security_group_ids  = ["${var.sgid}"],
  provisioner "file" {
  content      = "${file("${var.s3cfgFile}")}"
  destination = "${var.cfgdestination}"

  connection {
        user = "${var.user}"
        private_key = "${file("${var.key}")}"
    }
}


  provisioner "remote-exec" {
      inline = "${var.inlineparams}"
      connection {
            user = "${var.user}"
            private_key = "${file("${var.key}")}"
        }
  }
}




output "ip" {
  value = "${aws_instance.lenon.public_ip}"
}
