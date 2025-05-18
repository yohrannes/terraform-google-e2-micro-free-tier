module "service-account" {
  count   = var.enable_sa_resource ? 1 : 0
  source  = "yohrannes/service-account/google"
  version = "0.1.1"
  project = var.project_id
}