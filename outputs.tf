output "instance_public_ip" {
  description = "Instance public IP"
  value       = google_compute_instance.instance[0].network_interface[0].access_config[0].nat_ip
}

output "ssh_key_path" {
  description = "ssh key path:"
  value       = local.ssh_public_key
}
