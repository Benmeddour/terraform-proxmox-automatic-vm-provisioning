# Terraform Best Practices

## Table of Contents

1. Introduction
2. Directory Structure
3. Module Usage and Organization
4. State Management
5. Provider Versioning
6. Security and Compliance
7. Testing and Validation
8. CI/CD Integration
9. References

## Introduction

Terraform is an open-source infrastructure as code (IaC) tool that enables you to define, preview, and deploy cloud and on‑prem resources using a declarative configuration language. This document provides best practices to:

- Ensure consistent and predictable deployments
- Promote collaboration across teams
- Secure and manage infrastructure state
- Automate testing and validation

## Directory Structure

Adopting a consistent folder layout helps organize code and separate concerns:

### Simple Structure

```
├── credentials.auto.tfvars     # Proxmox credentials and VM settings
├── main.tf                     # Resource definitions
├── providers.tf                # Provider blocks and versions
├── variables.tf                # Input variable definitions
└── backend.tf                  # Remote state backend config (optional)
```

### Complex Structure

```
├── infra/                      # Reusable modules
│   ├── network/
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   └── compute/
│       ├── main.tf
│       ├── providers.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md
├── envs/                       # Environment-specific configs
│   ├── dev/
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   └── backend.tf
│   ├── prod/
│   │   ├── main.tf
│   │   ├── providers.tf
│   ├── variables.tf
│   └── backend.tf
├── globals.tf                  # Shared variables and providers
├── providers.tf                # Root provider blocks and versions
└── README.md                   # Documentation and best practices
```

Key points:

- For simple projects, a flat layout is sufficient to manage a single environment.
- For larger/production setups, separate reusable modules under `infra/` and environment configs under `envs/`.
- Ensure each folder (module or env) contains at minimum: `main.tf`, `providers.tf`, and `variables.tf`.
- Optionally include `outputs.tf` and `README.md` in each module.

## Module Usage and Organization

- Design modules to be small, focused, and parameterized
- Follow naming conventions for inputs, outputs, and resources
- Publish and version modules in a private or public registry
- Use semantic versioning (MAJOR.MINOR.PATCH)
- Avoid cross-module dependencies; pass required data via outputs

## State Management

- Store state remotely (e.g., AWS S3, Azure Blob Storage, Google Cloud Storage)
- Enable state locking (e.g., DynamoDB for AWS, Cosmos DB for Azure)
- Use workspaces or separate state files per environment
- Restrict access to state files to authorized principals
- Periodically backup state and enable versioning

## Provider Versioning

- Pin providers with version constraints:
  ```hcl
  terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 4.0"
      }
    }
  }
  ```
- Regularly review and upgrade provider versions in a controlled pipeline
- Lock Terraform CLI version via .terraform-version or tfenv

## Security and Compliance

- Never commit secrets; use environment variables or secret manager integrations (e.g., Vault)
- Enable IAM policies with least privilege
- Use policy-as-code tools (e.g., Sentinel, Open Policy Agent, Terraform Cloud Policy)
- Scan configurations with static analysis tools (e.g., tfsec, checkov)

## Testing and Validation

- Run `terraform fmt` and `terraform validate` in CI
- Use linters (e.g., tflint) to enforce style and detect errors
- Write unit and integration tests with Terratest or Kitchen-Terraform
- Automate security scans (e.g., tfsec, checkov) as part of the pipeline

## CI/CD Integration

- Separate plan and apply stages; require manual approvals for production
- Store and share plans for review before apply
- Automate drift detection and remediation in non-production environments
- Use Terraform Cloud, GitHub Actions, GitLab CI, or Jenkins to orchestrate runs

## References

- [Terraform Directory Structure Best Practices](https://youtu.be/8FwxDSwh5z4)
- [How To Structure Terraform Project (3 Levels)](https://youtu.be/nMVXs8VnrF4)
- [8 Terraform Best Practices that will improve your TF workflow immediately](https://youtu.be/gxPykhPxRW0)
