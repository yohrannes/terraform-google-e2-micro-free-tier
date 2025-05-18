# Run google ec2-micro instance (free tier).

This repository consists in simplify the process to provide a ec2-micro instance from terraform modules, to be initially used for free tier level.

## Useful for.
- Low-traffic web servers
- Back office apps
- Containerized microservices
- Small databases
- Development and test environments

## Instance specifications.

### S.O
- Ubuntu 24.04

### Capacity.
- vCPU: 2 (AMD64)
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
```
```
# If can't create a project with gcloud init, try...
gcloud projects create <GLOBAL_UNIQUE_PROJECT_NAME>
```
```
gcloud auth application-default login
```

### Link billing account to the project

### Provision infrastructure with terraform.
```
terraform init
terraform plan
terraform apply
```

## Contribute 🤝

We welcome contributions to improve this project! Here’s how you can help:

- **Repository**: [Here](https://github.com/yohrannes/terraform-google-e2-micro-free-tier/issues).
- **Report Issues**: If you encounter any problems, open a [GitHub issue](https://github.com/yohrannes/terraform-google-e2-micro-free-tier/issues).
- **Submit Enhancements**: Share your improvements by creating a [pull request](https://github.com/yohrannes/terraform-google-e2-micro-free-tier/pulls).
- **Suggest Features**: Have an idea? Start a discussion in the project’s repository.
