provider "aws" {}

resource "aws_instance" "jenkins" {
    //east1 ami
    ami = "ami-0bcc094591f354be2"
    instance_type = "t2.micro"
    key_name = "temp"
    security_groups = [aws_security_group.ssh.name]


    connection {
      user = "ubuntu"
      type = "ssh"
      private_key = file("./temp.pem")
      host = self.public_ip
      timeout = "20min"
    }

    provisioner "file"{
      source = "./jenkinsStart.sh"
      destination = "~/jenkinsStart.sh"
    }

    provisioner "remote-exec" {
      inline = [
        "sudo chmod 777 ~/jenkinsStart.sh",
        "sudo ~/jenkinsStart.sh",
        ]
    }

    lifecycle {
      create_before_destroy = true
    }

}

resource "aws_security_group" "ssh" {
  description = "Allow traffic on port 80 and ssh on 22"

  //traffic access
  ingress {
    from_port   = 0
    to_port     = 0
    protocol =   "-1"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  //traffic egress
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "instance_ip" {
    value=aws_instance.jenkins.public_ip
}
output "jenkins_adm" {
  value=file(/var/lib/jenkins/secrets/initialAdminPassword)
}

terraform {
    backend "s3" {
    }
}