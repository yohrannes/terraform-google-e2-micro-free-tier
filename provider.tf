terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.70"  # Recomend to use latest stable version
    }
  }
}

provider "google" {
  credentials = var.credentials_path
  project     = var.project_id
  region      = var.region
}