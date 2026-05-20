terraform {
  required_providers {
    excloud = {
      source = "excloud-dev/excloud"
    }
  }
}

provider "excloud" {}

# Minimal config shape for importing an existing VM.
#
# Replace these values with the existing VM's remote values, then run:
#
#   terraform import excloud_compute_instance.imported <vm_id>
#   terraform plan -input=false
#
# Omit root_password, user_data, and root_volume.name unless you intentionally
# want Terraform to replace the VM. Those create-time values are not reliably
# reconstructable from the compute read API.
resource "excloud_compute_instance" "imported" {
  name                 = "existing-vm-name"
  zone_id              = 1
  subnet_id            = 1324
  image_id             = 10
  instance_type        = "t1a.micro"
  allocate_public_ipv4 = false
  security_group_ids   = [2613]

  root_volume = {
    size_gib = 10
  }
}
