variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "proxmox_token_id" {
  description = "Proxmox API token ID"
  type        = string
  sensitive   = true
}

variable "proxmox_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  description = "Allow insecure TLS for Proxmox provider"
  type        = bool
  default     = true
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "vm_vmid" {
  description = "Unique VM ID"
  type        = number
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "pool" {
  description = "Name of the pool"
  type        = string
}

variable "target_node" {
  description = "Proxmox node to deploy the VM on"
  type        = string
}

variable "clone_template" {
  description = "Template to clone"
  type        = string
}

variable "full_clone" {
  description = "Perform a full clone"
  type        = bool
  default     = true
}

variable "agent" {
  description = "QEMU agent"
  type        = number
  default     = 1
}

variable "cores" {
  description = "Number of cores"
  type        = number
  default     = 1
}

variable "sockets" {
  description = "Number of sockets"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Memory in MB"
  type        = number
  default     = 1024
}

variable "cpu_type" {
  description = "CPU type"
  type        = string
  default     = "host"
}

variable "numa" {
  description = "Enable NUMA"
  type        = bool
  default     = false
}

variable "scsihw" {
  description = "SCSI hardware controller"
  type        = string
  default     = "virtio-scsi-pci"
}

variable "os_type" {
  description = "OS type"
  type        = string
  default     = "cloud-init"
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 16
}

variable "storage" {
  description = "Storage to use"
  type        = string
  default     = "local-lvm"
}

variable "discard" {
  description = "Enable discard"
  type        = bool
  default     = false
}

variable "network_model" {
  description = "Network adapter model"
  type        = string
  default     = "virtio"
}

variable "network_bridge" {
  description = "Bridge to attach network"
  type        = string
  default     = "vmbr0"
}

variable "firewall" {
  description = "Enable firewall"
  type        = bool
  default     = false
}

variable "link_down" {
  description = "Disable link"
  type        = bool
  default     = false
}

variable "ip_config" {
  description = "IP configuration string"
  type        = string
  default     = "ip=dhcp"
}

variable "ssh_keys" {
  description = "SSH public keys for cloud-init"
  type        = string
  sensitive   = true
}

variable "tfstate_bucket" {
  description = "S3 bucket for Terraform remote state"
  type        = string
}

variable "tfstate_lock_table" {
  description = "DynamoDB table for state locking"
  type        = string
}

variable "aws_region" {
  description = "AWS region for backend resources"
  type        = string
}
