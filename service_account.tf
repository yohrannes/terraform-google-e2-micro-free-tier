resource "google_service_account" "tf-web-port-sa" {
  account_id   = var.service_account_name
  display_name = var.service_account_name
  project      = var.project_id
  count        = var.create_sa ? 1 : 0
}

resource "google_service_account_key" "tf-web-port-sa-key" {
  service_account_id = google_service_account.tf-web-port-sa[0].name
  count              = var.create_sa ? 1 : 0
}

resource "google_project_iam_binding" "owner_binding" {
  project = var.project_id
  role    = "roles/editor"
  members = ["serviceAccount:${google_service_account.tf-web-port-sa[0].email}"]
  count   = var.create_sa ? 1 : 0
}

resource "google_project_iam_binding" "config_agent_binding" {
  project = var.project_id
  role    = "roles/config.agent"
  members = ["serviceAccount:${google_service_account.tf-web-port-sa[0].email}"]
  count   = var.create_sa ? 1 : 0
}

resource "google_project_iam_binding" "viewer_binding" {
  project = var.project_id
  role    = "roles/viewer"
  members = ["serviceAccount:${google_service_account.tf-web-port-sa[0].email}"]
  count   = var.create_sa ? 1 : 0
}

/* resource "google_project_iam_binding" "compute_network_admin_binding" {
  project = var.project_id
  role    = "roles/compute.networkAdmin"
  members = ["serviceAccount:${google_service_account.tf-web-port-sa[0].email}"]
}

resource "google_project_iam_binding" "compute_security_admin_binding" {
  project = var.project_id
  role    = "roles/compute.securityAdmin"
  members = ["serviceAccount:${google_service_account.tf-web-port-sa[0].email}"]
}

resource "google_project_iam_binding" "compute_admin_binding" {
  project = var.project_id
  role    = "roles/compute.admin"
  members = ["serviceAccount:${google_service_account.tf-web-port-sa[0].email}"]
}


resource "google_project_iam_binding" "service_account_user_binding" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  members = ["serviceAccount:${google_service_account.tf-web-port-sa[0].email}"]
}

resource "google_project_iam_binding" "token_creator_binding" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  members = ["serviceAccount:${google_service_account.tf-web-port-sa[0].email}"]
} */