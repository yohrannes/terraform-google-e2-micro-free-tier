output "instance_public_ip" {
  description = "Instance public IP:"
  value       = google_compute_instance.instance[0].network_interface[0].access_config[0].nat_ip
}

output "connect_command" {
  description = "Connection command:"
  value       = "ssh ${var.instance_user}@${google_compute_instance.instance[0].network_interface[0].access_config[0].nat_ip} -i ${var.ssh_key}"
}