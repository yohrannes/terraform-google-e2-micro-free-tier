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

# Set project id env

gcloud auth application-default login
gcloud config set project $GOOGLE_CLOUD_PROJECT
gcloud services enable cloudresourcemanager.googleapis.com --project=$GOOGLE_CLOUD_PROJECT
gcloud services enable compute.googleapis.com --project=$GOOGLE_CLOUD_PROJECT

gcloud projects add-iam-policy-binding tf-website-portifolio \
  --member="user:$(gcloud config get-value account)" \
  --role="roles/iam.serviceAccountAdmin"
```

### Link billing account to the project

### Provision infrastructure with terraform.
```
terraform init -upgrade
terraform plan -out plan
terraform apply
```