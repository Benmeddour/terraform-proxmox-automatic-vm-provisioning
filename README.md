# Automatic Proxmox VM provisioning with Terraform

A comprehensive Terraform repository for automating virtual machine provisioning and management in Proxmox Virtual Environment (PVE). This repository provides multiple approaches for VM deployment, from simple single-VM configurations to scalable multi-VM K3s cluster setups. You can learn more about Terraform in the [wiki](https://github.com/Benmeddour/terraform-proxmox-automatic-vm-provisioning/wiki).

## 🎯 Purpose

This repository demonstrates various Terraform patterns for:

- **Automated VM provisioning** in Proxmox environments
- **K3s/Kubernetes cluster deployment** with control and worker nodes
- **Infrastructure as Code (IaC)** best practices
- **Scalable VM management** with parameterized configurations

## 📁 Repository Structure

```
automation_terraform/
├── README.md                                    # This documentation
├── terraform.tf                                 # Root-level simple VM configuration with detailed explainations of each parameter
├── Create_k8s-cluster_vms/                                 # ✅ Recommended: Modular approach
│   ├── credentials.auto.tfvars                 # VM configuration and secrets
│   ├── main.tf                                 # VM resource definitions
│   ├── providers.tf                            # Provider configurations 
│   └── variables.tf                            # Input variable definitions
├── create_vms_in_one_terraform_file/           # Simple single-file approach
│   └── create_newk3sworker_vm.tf               # All-in-one VM configuration
└── Terraform_best_practice/                    # Best practices example
    ├── credentials.auto.tfvars                 # Configuration values
    ├── main.tf                                 # Resource definitions
    ├── providers.tf                            # Provider setup
    ├── variables.tf                            # Variable declarations
    └── terraform_best_practice.md              # Comprehensive guide
```

## 🚀 Quick Start

### Prerequisites

1. **Terraform** (>= 0.14)
2. **Proxmox VE** cluster with API access
3. **VM Template** (k3s-template or k8s-template) pre-configured in Proxmox
4. **API Token** created in Proxmox for Terraform authentication

### 1. Clone and Setup

```bash
git clone <repository-url>
cd automation_terraform
```

### 2. Choose Your Approach

#### Option A: Modular Approach (Recommended)

```bash
cd Create_vms/
```

#### Option B: Simple Single-File

```bash
cd create_vms_in_one_terraform_file/
```

#### Option C: Best Practices Example

```bash
cd Terraform_best_practice/
```

### 3. Configure Credentials

Edit the `credentials.auto.tfvars` file with your environment details:

```hcl
# Proxmox Connection
proxmox_api_url       = "https://YOUR_PROXMOX_IP:8006/api2/json"
proxmox_token_id      = "terraform@pam!terraformAPI"
proxmox_token_secret  = "your-secret-token"

# VM Configuration
vm_count             = 6
vm_names             = ["control-node-1", "control-node-2", "control-node-3", "worker-node-1", "worker-node-2", "worker-node-3"]
target_nodes         = ["pmox02","pmox02","pmox02","pmox02","pmox02","pmox04"]
```

### 4. Deploy Infrastructure

```bash
# Initialize Terraform
terraform init

# Review the execution plan
terraform plan

# Apply the configuration
terraform apply
```

## 📋 Configuration Examples

### Multi-VM K3s Cluster (Create_vms/)

This approach creates a complete K3s cluster with separate control and worker nodes:

**Key Features:**

- **6 VMs total**: 3 control nodes + 3 worker nodes
- **High Availability**: Distributed across multiple Proxmox nodes
- **Resource Optimization**: Different CPU/memory allocations per role
- **Network Configuration**: Static IPs for control nodes, DHCP for workers
- **Cloud-init Support**: Automated initial configuration

**VM Specifications:**

- **Control Nodes**: 2 cores, 4GB RAM, 64GB disk
- **Worker Nodes**: 6 cores, 8GB RAM, 64GB disk
- **Storage**: pmoxpool01 (SSD emulation enabled)
- **Network**: mainvnet bridge with firewall disabled

### Single VM Testing (create_vms_in_one_terraform_file/)

Perfect for testing and development:

**Key Features:**

- **Single VM deployment**
- **All configuration in one file**
- **Quick setup and teardown**
- **Minimal resource usage**

### Best Practices Implementation (Terraform_best_practice/)

Demonstrates proper Terraform structure:

**Key Features:**

- **Separated configuration files**
- **Proper variable management**
- **Provider version constraints**
- **Security best practices**

## 🔧 VM Templates

The configurations assume pre-existing VM templates in Proxmox:

### k3s-template

- **Purpose**: K3s cluster nodes
- **OS**: Ubuntu/Debian-based
- **Features**: Cloud-init enabled, Docker/containerd pre-installed

### k8s-template

- **Purpose**: General Kubernetes workloads
- **OS**: Ubuntu/Debian-based
- **Features**: Cloud-init enabled, basic container runtime

## 🌐 Network Configuration

### Control Nodes (Static IP)

```hcl
ip_config = [
  "ip=192.168.0.5/16,gw=192.168.0.1",
  "ip=192.168.0.6/16,gw=192.168.0.1",
  "ip=192.168.0.7/16,gw=192.168.0.1"
]
```

### Worker Nodes (DHCP)

```hcl
ip_config = ["ip=dhcp", "ip=dhcp", "ip=dhcp"]
```

### DNS Configuration

```hcl
nameserver = "8.8.8.8"
```

## 🔐 Security Configuration

### SSH Access

```hcl
# SSH key injection via cloud-init
sshkeys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP8mGrP9ceX0JmrTXkVp7x/nsaLiyxPF68paem0zOu55 admin-ubt"

# Default user credentials
ciuser     = "admin-ubt"
cipassword = "admin"
```

### API Authentication

```hcl
# Proxmox API token (stored in credentials.auto.tfvars)
pm_api_token_id     = "terraform@pam!terraformAPI"
pm_api_token_secret = "your-secret-token"
pm_tls_insecure     = true  # For self-signed certificates
```

## 📊 Resource Management

### Proxmox Features

- **Resource Pools**: `Backup-vms-pool` for organized management
- **High Availability**: Configured with `mainHA` group
- **Tags**: Role-based tagging (`ctl` for control, `wrk` for worker)
- **Hot-plug**: Support for `disk,network,usb` components

### Storage Configuration

- **Primary Storage**: `pmoxpool01` (SSD pool)
- **Disk Size**: 64GB for cluster nodes, 16GB for test VMs
- **Features**: Discard/TRIM support, SSD emulation

## 🛠️ Customization

### Adding New VMs

1. Update `vm_count` in `credentials.auto.tfvars`
2. Add entries to `vm_names`, `vm_vmids`, `target_nodes` arrays
3. Configure resource allocation in `cores`, `sockets`, `memory` arrays
4. Set network configuration in `ip_config` array

### Changing VM Specifications

Modify the relevant variables in `credentials.auto.tfvars`:

```hcl
cores    = [2, 2, 2, 4, 4, 4]  # CPU cores per VM
sockets  = [1, 1, 1, 2, 2, 2]  # CPU sockets per VM
memory   = [4096, 4096, 4096, 8192, 8192, 8192]  # RAM in MB
```

## 🧪 Testing and Validation

### Pre-deployment Checks

```bash
# Format code
terraform fmt

# Validate configuration
terraform validate

# Security scan (if tfsec installed)
tfsec .
```

### Post-deployment Verification

```bash
# Check VM status in Proxmox
# Verify SSH connectivity
ssh admin-ubt@192.168.0.5

# Test K3s cluster (for cluster deployments)
kubectl get nodes
```

## 📖 Best Practices

This repository follows Terraform best practices including:

- ✅ **Version Constraints**: Pinned provider versions
- ✅ **Variable Management**: Separated configuration from code
- ✅ **State Management**: Proper state file handling
- ✅ **Security**: Sensitive variables marked appropriately
- ✅ **Documentation**: Comprehensive inline comments
- ✅ **Modularity**: Reusable configuration patterns

For detailed best practices, see: `Terraform_best_practice/terraform_best_practice.md`

## 🔍 Troubleshooting

### Common Issues

1. **API Connection Errors**

   - Verify Proxmox API URL and port (8006)
   - Check API token permissions
   - Ensure TLS settings match your environment

2. **VM ID Conflicts**

   - Use unique VM IDs across your Proxmox cluster
   - Check existing VMs before deployment

3. **Template Not Found**

   - Verify template name exists in Proxmox
   - Ensure template is accessible from target node

4. **Network Configuration**
   - Verify bridge names match your Proxmox setup
   - Check IP ranges don't conflict with existing infrastructure

### State Management Issues

```bash
# Reset state if corrupted
terraform state list
terraform state rm <resource_name>  # Remove problematic resources
terraform import <resource_name> <resource_id>  # Re-import if needed
```


## 📚 Additional Resources

- [Terraform Proxmox Provider Documentation](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)
- [Proxmox VE API Documentation](https://pve.proxmox.com/wiki/Proxmox_VE_API)
- [K3s Documentation](https://k3s.io/)
- [Cloud-init Documentation](https://cloud-init.io/)

## 📄 License

This project is provided as-is for educational and automation purposes. Please review and adapt configurations for your specific environment and security requirements.

---

**Note**: Always review and test configurations in a non-production environment before deploying to production systems. Ensure proper backup procedures are in place for your Proxmox environment.
