locals {
  ssh_public_key = file("/root/.ssh/id_rsa.pub")
  credentials    = file("~/.gcp/credentials.json")
  formatted_key  = "${var.instance_user}:${trimspace(local.ssh_public_key)}"
  startup_script_path = templatefile("${path.module}/startup-files/startup-script.sh",{})
}

variable "instance_user" {
  type = string
  description = "Base Installation User"
  default = "ubuntu"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "instance_name" {
  type        = string
  description = "Instance name"
  default = "instance-free-tier"
}

variable "ip_cidr_range" {
  type        = string
  description = "CIDR range"
  default = "10.0.0.0/24"
}

# Available in the folowing regions
#  Oregon: us-west1
#  Iowa: us-central1
#  South Carolina: us-east1

variable "region" {
  type        = string
  description = "Region name"
  default = "us-west1" 
}

variable "zone" {
  type        = string
  description = "Zone name"
  default = "us-west1-a"
}