module "service-account" {
  source  = "yohrannes/service-account/google"
  version = "0.1.1"
  project_id = var.project_id # Required
  enable_sa_resource = var.enable_sa_resource
}