locals {
  ssh_public_key      = file(var.ssh_key_path)
  formatted_key       = "${var.instance_user}:${trimspace(local.ssh_public_key)}"
  startup_script_path = templatefile("${var.startup_script_path}", {})
}

variable "ssh_key_path" {
  type        = string
  description = "Desired ssh_key path (Ex. ~/.ssh/id_rsa.pub)"
}

variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "credentials_path" {
  type        = string
  description = "Provider credentials path (Ex. ~/.gcp/credentials.json)"
  default     = null
}

variable "enable_sa_resource" {
  description = "Enable service account resource"
  type        = bool
  default     = false
}

variable "startup_script_path" {
  type        = string
  description = "Startup script file path (Ex. <ROOT_MODULE_PATH>/startup-script.sh)"
  default     = "./startup-script.sh"
}

variable "instance_user" {
  type        = string
  description = "System based installation user"
  default     = "ubuntu"
}

variable "instance_name" {
  type        = string
  description = "Instance name"
  default     = "tf-web-instance"
}

variable "machine_type" {
  type        = string
  description = "Machine type"
  default     = "e2-micro"
}

variable "ip_cidr_range" {
  type        = string
  description = "CIDR range"
  default     = "10.0.0.0/24"
}

variable "region" {
  type        = string
  description = "Region name (Free tier allowed in us-west1, us-central and us-east1)"
  default     = "us-east1"
  validation {
    condition     = (var.region == "us-east1") || (var.region == "us-west1") || (var.region == "us-central1")
    error_message = "This region are not on google free tier (allowed just in us-west1, us-central and us-east1), if you really need to specify another region see variables.tf and exclude validation block in region variable block, after that, set the variable region value with the region that you want"
  }
}

variable "zone" {
  type        = string
  description = "Zone name"
  default     = "us-east1-b"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Number of web instances to deploy, just one instance by default (Free tier)."

  validation {
    condition     = var.instance_count == 1
    error_message = "This module requires just one instance by default (Free tier). If you want to deploy more instances, see variables.tf and exclude validation block in web_instance_count variable block, after that, set the variable value with the quantity that you want"
  }
}