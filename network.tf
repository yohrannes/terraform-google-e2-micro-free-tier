resource "google_compute_network" "vpc" {
  name                    = "vpc"
  auto_create_subnetworks = false

  depends_on = [google_project_service.cloudresourcemanager_api, google_project_service.compute_engine_api]
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet"
  ip_cidr_range = var.ip_cidr_range
  network       = google_compute_network.vpc.self_link
}

resource "google_compute_firewall" "frule-allow-http-https-ssh-icmp" {
  name          = "frule-allow-http-https-ssh-icmp"
  network       = google_compute_network.vpc.self_link
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }

}