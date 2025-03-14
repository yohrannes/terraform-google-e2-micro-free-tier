provider "google" {
  credentials = local.credentials
  project     = var.project_id
  region      = var.region
}

resource "google_compute_network" "vpc" {
  name                    = "vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet"
  ip_cidr_range = var.ip_cidr_range
  network       = google_compute_network.vpc.self_link
}

resource "google_compute_firewall" "frule-allow-http-https-ssh-icmp" {
  name    = "frule-allow-http-https-ssh-icmp"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "instance" {
  zone  = var.zone
  name  = var.instance_name
  count = var.web_instance_count

  boot_disk {
    auto_delete = true
    device_name = "instance-boot-disk"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20241219"
      size  = 30
      type  = "pd-standard"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm-add-from-tf"
  }

  machine_type = "e2-micro"

  metadata = {
    ssh-keys = local.formatted_key
  }

  metadata_startup_script = local.startup_script_path

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

}

