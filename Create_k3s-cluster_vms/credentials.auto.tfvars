proxmox_api_url       = "https://your-proxmox-ip-address:8006/api2/json"
proxmox_token_id      = "terraform@pam!terraformAPI"
proxmox_token_secret  = "d73c9bde-c055-4fa3-aede-e7dccab3fe64"
vm_vmids             = [111, 112, 113, 122, 123, 124]
vm_count             = 6
vm_names             = ["control-node-1", "control-node-2", "control-node-3", "worker-node-1", "worker-node-2", "worker-node-3"]
target_nodes         = ["pmox02","pmox02","pmox02","pmox02","pmox02","pmox04"]
clone_template       = "k3s-template"
hagroup              = "mainHA"
hastate              = "started"
cores                = [2, 2, 2, 2, 2, 2]
sockets              = [1, 1, 1, 3, 3, 3]
memory               = [4096, 4096, 4096, 8192, 8192, 8192]
cpu_type             = "host"
scsihw               = "virtio-scsi-pci"
os_type              = "cloud-init"
tags                 = ["ctl", "ctl", "ctl", "wrk", "wrk", "wrk"]

disk_size            = 64
storage              = "pmoxpool01"
pool                 = "Backup-vms-pool"
network_model        = "virtio"
network_bridge       = "mainvnet"


nameserver           = "8.8.8.8"
ip_config            = ["ip=192.168.0.5/16,gw=192.168.0.1", "ip=192.168.0.6/16,gw=192.168.0.1", "ip=192.168.0.7/16,gw=192.168.0.1","ip=dhcp","ip=dhcp", "ip=dhcp"]
ciuser               = "admin-ubt"
cipassword           = "admin"
ssh_keys             = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP8mGrP9ceX0JmrTXkVp7x/nsaLiyxPF68paem0zOu55 admin-ubt"


