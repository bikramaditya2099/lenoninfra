
variable "ami" {
  default = "ami-4218403a"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "lenon"
}


variable "s3cfgFile" {
  default = "s3cfg.txt"
}
variable "cfgdestination" {
  default = "/tmp/.s3cfg"
}
variable "user" {
  default = "ubuntu"
}
variable "key" {
  default = "lenon.pem"
}

variable "inlineparams" {
  default =  ["sudo apt-get install awscli s3cmd -y",
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
    "sudo s3cmd get s3://lenonjar/* /home/ubuntu/",
    "sudo nohup java -jar /home/ubuntu/Lenon-0.0.1.jar &",
    "sleep 1"
    ]
}

variable "sgname" {
  default = "lenon-sg"
}

variable "sgdescription" {
  default = "Security group"
}
