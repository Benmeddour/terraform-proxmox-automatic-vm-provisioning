variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "hagroup" {
  description = "HA group for the VM"
  type        = string
  default     = "mainHA"
}

variable "hastate" {
  description = "HA state for the VM"
  type        = string
  default     = "started"
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
}

variable "vm_vmids" {
  description = "Unique VM ID"
  type        = list(number)
}

variable "vm_names" {
  description = "Name of the VMs"
  type        = list(string)
}

variable "target_nodes" {
  description = "Proxmox node where each VM deploy"
  type        = list(string)
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
  type        = list(number)
}

variable "sockets" {
  description = "Number of sockets"
  type        = list(number)
}

variable "memory" {
  description = "Memory in MB"
  type        = list(number)
}

variable "tags" {
  description = "Tags for helps"
  type        = list(string)
}

variable "cpu_type" {
  description = "CPU type"
  type        = string
  default     = "host"
}

variable "numa" {
  description = "disable NUMA"
  type        = bool
  default     = false
}

variable "hotplug" {
  description = "Enable hotplug"
  type        = string
  default     = "disk,network,usb"
}

variable "scsihw" {
  description = "SCSI hardware controller"
  type        = string
  default     = "virtio-scsi-pci"
}

variable "balloon" {
  description = "Enable ballooning"
  type        = number
  default     = 0
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

variable "emulatedssd" {
  description = "Enable SSD emulation for the disk"
  type        = bool
  default     = true
}

variable "network_model" {
  description = "Network adapter model"
  type        = string
  default     = "virtio"
}

variable "onboot" {
  description = "Enable starting when the host start"
  type        = bool
  default     = true
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
  type        = list(string)
  default     = ["ip=dhcp", "ip=dhcp", "ip=dhcp", "ip=dhcp", "ip=dhcp"]
}

variable "ssh_keys" {
  description = "SSH public keys for cloud-init"
  type        = string
  sensitive   = true
}

variable "ciuser" {
  description = "Cloud-init user"
  type        = string
}

variable "cipassword" {
  description = "Cloud-init password"
  type        = string
  sensitive   = true
}

variable "nameserver" {
  description = "Nameserver for cloud-init"
  type        = string
  default     = "8.8.8.8 8.8.4.4"
}

variable "ciupgrade" {
  description = "Enable cloud-init upgrade"
  type        = bool
  default     = true
}

variable "pool" {
  description = "Enable SSD emulation for the disk"
  type        = string
}

