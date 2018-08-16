variable "access_key" {
  default = "AKIAIQI7VZMQR42TJSMA"
}
variable "secret_key" {
  default = "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"
}
data "aws_s3_bucket_object" "secret_key" {
  bucket = "lenon-jar"
  key    = "Lenon-0.0.1.jar"
}



resource "aws_instance" "lenon" {
  ami           = "ami-4218403a"
  instance_type = "t2.micro",
  key_name="lenon",
  security_groups = [
    "lenon-sg"
  ],
  provisioner "file" {
  content      = "${file("s3cfg.txt")}"
  destination = "/tmp/.s3cfg"

  connection {
        user = "ubuntu"
        private_key = "${file("lenon.pem")}"
    }
}

provisioner "file" {
content      = "${file("downloadjava.sh")}"
destination = "/tmp/downloadjava.sh"

connection {
      user = "ubuntu"
      private_key = "${file("lenon.pem")}"
  }
}

  provisioner "remote-exec" {
      inline = [
        "sudo apt-get install awscli s3cmd -y",
        "sudo apt-get install unzip",
        "sudo cp /tmp/.s3cfg /root/.s3cfg",
        "set -ex",
        "sudo apt-get update",
        "sudo apt-get install -y python-software-properties debconf-utils",
        "sudo add-apt-repository -y ppa:webupd8team/java",
        "sudo apt-get update",
        "echo \"oracle-java8-installer shared/accepted-oracle-license-v1-1 select true\" | sudo debconf-set-selections",
        "sudo apt-get install -y oracle-java8-installer",
        "sudo cp /tmp/.s3cfg /home/ubuntu/.s3cfg",
        "sudo s3cmd get s3://lenon-jar/* /home/ubuntu/",
        "sudo nohup java -jar /home/ubuntu/Lenon-0.0.1.jar &",
        "sleep 1"
      ]
      connection {
            user = "ubuntu"
            private_key = "${file("lenon.pem")}"
        }
  }
}

resource "aws_security_group" "lenon-sg" {
  name        = "lenon-sg"
  description = "Security group for lenon"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8090
    to_port     = 8090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }
}

output "ip" {
  value = "${aws_instance.lenon.public_ip}"
}
