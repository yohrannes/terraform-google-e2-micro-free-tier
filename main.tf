resource "google_project_service" "cloudresourcemanager_api" {
  project            = var.project_id
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "compute_engine_api" {
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_instance" "instance" {
  zone                    = var.zone
  name                    = var.instance_name
  machine_type            = var.machine_type
  count                   = var.instance_count
  metadata_startup_script = local.startup_script_path
  can_ip_forward          = false
  deletion_protection     = false
  enable_display          = false

  labels = {
    goog-ec-src = "vm-add-from-tf"
  }

  metadata = {
    ssh-keys = local.formatted_key
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

  boot_disk {
    auto_delete = true
    device_name = "instance-boot-disk"
    mode        = "READ_WRITE"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20241219"
      size  = 30
      type  = "pd-standard"
    }

  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
  }

}