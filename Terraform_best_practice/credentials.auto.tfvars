proxmox_api_url       = "https://your-proxmox-ip-address:8006/api2/json"
proxmox_token_id      = "terraform@pam!terraformAPI"
proxmox_token_secret  = "68e2fe93-34a7-44e0-bc03-f6684f1d8e69"
proxmox_tls_insecure  = true

vm_count             = 1
vm_vmid              = 107
vm_name              = "vm-terraform1"
target_node          = "pmox01"
clone_template       = "k8s-template"
full_clone           = true
agent                = 1
cores                = 1
sockets              = 1
memory               = 1024
cpu_type             = "host"
numa                 = false
scsihw               = "virtio-scsi-pci"
os_type              = "cloud-init"
pool		     = "Backup-vms-pool"

disk_size            = 16
storage              = "local-lvm"
discard              = false

network_model        = "virtio"
network_bridge       = "vmbr0"
firewall             = false
link_down            = false
ip_config            = "ip=dhcp"

ssh_keys             = "<<EOF   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP8mGrP9ceX0JmrTXkVp7x/nsaLiyxPF68paem0zOu55 admin-ubt   EOF"