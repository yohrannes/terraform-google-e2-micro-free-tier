terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"  # Use latest stable version
    }
  }
}

provider "google" {
  credentials = var.credentials_path != "" ? file(var.credentials_path) : null
  project     = var.project_id
  region      = var.region
}