locals {
  ssh_public_key      = file(var.ssh_key_path)
  credentials         = file(var.credentials_path)
  formatted_key       = "${var.instance_user}:${trimspace(local.ssh_public_key)}"
  startup_script_path = templatefile("${path.module}/startup-files/startup-script.sh", {})
}

variable "project_id" {
  type        = string
  description = "Project id"
}

variable "credentials_path" {
  type = string
  description = "Provider credentials path (Ex. ~/.gcp/credentials.json)"
}

variable "ssh_key_path" {
  type = string
  description = "Desired ssh_key path"
  default = "~/.ssh/id_rsa.pub"
}

variable "instance_user" {
  type        = string
  description = "System based installation user"
  default     = "ubuntu"
}

variable "instance_name" {
  type        = string
  description = "Instance name"
  default     = "instance-free-tier"
}

variable "ip_cidr_range" {
  type        = string
  description = "CIDR range"
  default     = "10.0.0.0/24"
}

# Available in the folowing regions
#  Oregon: us-west1
#  Iowa: us-central1
#  South Carolina: us-east1

variable "region" {
  type        = string
  description = "Region name"
  default     = "us-east1"
}

variable "zone" {
  type        = string
  description = "Zone name"
  default     = "us-east1-b"
}

variable "web_instance_count" {
  type        = number
  default     = 1
  description = "Number of web instances to deploy, just one instance by default (Free tier)."

  validation {
    condition     = var.web_instance_count == 1
    error_message = "This module requires just one instance by default (Free tier). If you want to deploy more instances, see variables.tf and exclude validation block in web_instance_count variable block, after that, set the variable value with the quantity that you want"
  }
}