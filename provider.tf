terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.84.0"  # Recomend to use latest stable version
    }
  }
}

provider "google" {
  credentials = var.credentials_path != "" ? file(var.credentials_path) : null
  project     = var.project_id
  region      = var.region
}