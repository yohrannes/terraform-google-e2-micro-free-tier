# Run google ec2-micro instance (free tier).

This repository consists in simplify the process to provide a ec2-micro instance from terraform modules, to be initially used for free tier level.

## Usefull for.
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
- Goocle Cloud CLI

### Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) and [Google cloud CLI](https://cloud.google.com/sdk/docs/install-sdk) (recomend to use official doc's).

### Autenticate with your desired Google Account create a Project (skip if you already had it)..
```
gcloud init

# If can't create a project with gcloud init, try...
gcloud projects create <GLOBAL_UNIQUE_PROJECT_NAME>
```

### Create and give permissions to one [Service account](https://cloud.google.com/iam/docs/understanding-roles#compute-engine-roles) for security (skip if you already had it).

```
gcloud iam service-accounts create <SERVICE_ACCOUNT_NAME> --display-name "<SERVICE_ACCOUNT_NAME>"

# Copy service account e-mail
gcloud iam service-accounts list

SERVICE_ACCOUNT_EMAIL="<SERVICE_ACCOUNT_EMAIL>"
GOOGLE_CLOUD_PROJECT="<GLOBAL_UNIQUE_PROJECT_NAME>"

# Give permissions do this service account to provide instances.
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
  --member "serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role "roles/compute.instanceAdmin.v1" && \
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
  --member "serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role "roles/compute.networkAdmin" && \
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
  --member "serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role "roles/cloudbuild.integrationsOwner" && \
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
  --member "serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role "roles/vpcaccess.serviceAgent" && \
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
  --member "serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role "roles/compute.securityAdmin"
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
  --member "serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role "roles/compute.admin"

```

### Provision infrastructure with terraform.
```
terraform init -upgrade
terraform plan -out plan
terraform apply
```