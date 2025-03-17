# Run google ec2-micro instance (free tier).

This repository consists in simplify the process to provide a ec2-micro instance from terraform modules, to be initially used for free tier level.

## Useful for.
- Low-traffic web servers
- Back office apps
- Containerized microservices
- Small databases
- Development and test environments

## Instance specifications.

### Capacity.
- vCPU: 2
- Memory: 1GB

### Firewall.
- Allowed ICMP port
- Allowed TCP port (80, 443, 22)

## How to provide.

Required tools
- Terraform
- Google Cloud CLI

### Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) and [Google cloud CLI](https://cloud.google.com/sdk/docs/install-sdk) (recommend to use official doc's).

### Authenticate with your desired Google Account and create a Project (skip if you already have it)..
```
gcloud init

# If can't create a project with gcloud init, try...
gcloud projects create <GLOBAL_UNIQUE_PROJECT_NAME>
```

### Create and give permissions to one [Service account](https://cloud.google.com/iam/docs/understanding-roles#compute-engine-roles) for security (skip if you already have it).

```
gcloud iam service-accounts create <SERVICE_ACCOUNT_NAME> --display-name "<SERVICE_ACCOUNT_NAME>"

# Copy service account e-mail
gcloud iam service-accounts list

SERVICE_ACCOUNT_EMAIL="<SERVICE_ACCOUNT_EMAIL>"
GOOGLE_CLOUD_PROJECT="<GLOBAL_UNIQUE_PROJECT_NAME>"

# Give permissions do this service account to provide instances.
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
  --member "serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role "roles/compute.admin" \
  --role "roles/compute.networkAdmin" \
  --role "roles/compute.securityAdmin" \
  --role "roles/iam.serviceAccountUser" \
  --role "roles/viewer"

```

### Provision infrastructure with terraform.
```
terraform init -upgrade
terraform plan -out plan
terraform apply
```