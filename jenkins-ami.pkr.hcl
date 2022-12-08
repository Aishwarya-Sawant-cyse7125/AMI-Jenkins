packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

// define variables
variable "source_ami" {
  type    = string
  default = ""
}

variable "ami_region" {
  type    = string
  default = ""
}

variable "ami_name" {
  type    = string
  default = ""
}

variable "ssh_username" {
  type    = string
  default = "ec2-user"
}

variable "AWS_ACCESS_KEY_ID" {
  type    = string
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  type    = string
  default = ""
}

variable "AMI_USERS" {
  type    = list(string)
  default = []
}

// source - amazon-ebs, shared with demo account
source "amazon-ebs" "ubuntu" {
  access_key    = "${var.AWS_ACCESS_KEY_ID}"
  secret_key    = "${var.AWS_SECRET_ACCESS_KEY}"
  region        = "${var.ami_region}"
  instance_type = "t2.micro"
  source_ami    = "${var.source_ami}"
  ssh_username  = "${var.ssh_username}"
  ami_name      = "${var.ami_name}"
  ami_description = "This ami is custom created for a Jenkins server with Nginx reverse proxy"
  ami_users       = "${var.AMI_USERS}"
}

// build with all the provisioners
build {

  name = "Jenkins-AMI"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    script = "buildscript.sh"
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }

  post-processor "shell-local" {
    inline = [
      "echo Done Building AMI Image"
    ]
  }
}