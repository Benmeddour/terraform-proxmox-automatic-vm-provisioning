resource "proxmox_vm_qemu" "vm_terraform" {
  count       = var.vm_count
  vmid        = var.vm_vmid
  name        = var.vm_name
  target_node = var.target_node
  clone       = var.clone_template
  full_clone  = var.full_clone
  agent       = var.agent
  cores       = var.cores
  sockets     = var.sockets
  memory      = var.memory
  cpu_type    = var.cpu_type
  numa        = var.numa
  scsihw      = var.scsihw
  os_type     = var.os_type
  pool        = var.pool

  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size    = var.disk_size
          storage = var.storage
          discard = var.discard
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = var.storage
        }
      }
      ide2 {
        cdrom {}
      }
    }
  }

  network {
    id        = 0
    model     = var.network_model
    bridge    = var.network_bridge
    firewall  = var.firewall
    link_down = var.link_down
  }
  ipconfig0 = var.ip_config

  sshkeys = var.ssh_keys
}
