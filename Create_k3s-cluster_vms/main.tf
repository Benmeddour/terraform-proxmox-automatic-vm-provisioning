resource "proxmox_vm_qemu" "vm_terraforms" {
  count       = var.vm_count
  # you could use vmid = 100 + count.index to generate unique vmids
  # but it's better to use a list of vmids to avoid conflicts with existing VMs
  vmid        = var.vm_vmids[count.index]

  # you could use name = "vm-${count.index}" or "vm-${count.index +1}" to generate unique names
  # but it's better to use a list of names to avoid conflicts with existing VMs
  name        = var.vm_names[count.index]

  target_node = var.target_nodes[count.index]
  clone       = var.clone_template
  full_clone  = var.full_clone
  agent       = var.agent
  cores       = var.cores[count.index]
  sockets     = var.sockets[count.index]
  memory      = var.memory[count.index]
  cpu_type    = var.cpu_type
  numa        = var.numa
  scsihw      = var.scsihw
  onboot      = var.onboot
  os_type     = var.os_type
  pool        = var.pool
  tags        = var.tags[count.index]
  balloon     = var.balloon
  hotplug     = var.hotplug

  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size        = var.disk_size
          storage     = var.storage
          discard     = var.discard
          emulatessd  = var.emulatedssd
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = var.storage
        }
      }
    }
  }

  hagroup = var.hagroup
  hastate = var.hastate


  network {
    id        = 0
    model     = var.network_model
    bridge    = var.network_bridge
    firewall  = var.firewall
    link_down = var.link_down
  }

  #cicustom    = var.cicustom # e.g. "user=local:snippets/user-data.yaml,network=local:snippets/network-config.yaml" for cloud-init firstboot
  ciupgrade   = var.ciupgrade
  nameserver  = var.nameserver
  ipconfig0   = var.ip_config[count.index]
  sshkeys     = var.ssh_keys
  ciuser      = var.ciuser
  cipassword  = var.cipassword
}
