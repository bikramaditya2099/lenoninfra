
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
  default =  [
    "wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -",
    "echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list",
    "sudo apt-get update",
    "sudo apt-get install -y python-software-properties debconf-utils",
    "sudo add-apt-repository -y ppa:webupd8team/java",
    "sudo apt-get update",
    "echo \"oracle-java8-installer shared/accepted-oracle-license-v1-1 select true\" | sudo debconf-set-selections",
    "sudo apt-get install -y oracle-java8-installer",
    "sudo apt-get install jenkins -y",
    "sudo apt-get install systemd -y",
    "sudo ufw allow 8080",
    "sudo ufw allow OpenSSH",
    "sudo ufw --force enable"
    ]
}

variable "sgname" {
  default = "jenkins-sg"
}

variable "sgdescription" {
  default = "Security group"
}
