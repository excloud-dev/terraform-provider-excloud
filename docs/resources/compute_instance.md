---
page_title: "excloud_compute_instance Resource - excloud"
description: |-
  Manages an Excloud compute instance.
---

# excloud_compute_instance

Manages a compute instance. This resource creates billable infrastructure.

## Example Usage

```hcl
resource "excloud_compute_instance" "example" {
  name                 = "example-vm"
  zone_id              = 1
  subnet_id            = 1
  image_id             = 1
  instance_type        = "t1a.micro"
  allocate_public_ipv4 = false
  ssh_pubkey           = excloud_ssh_key.example.public_key
  security_group_ids   = [tonumber(excloud_security_group.example.id)]

  root_volume = {
    size_gib = 10
  }
}
```

## Arguments

- `name` - Instance name.
- `zone_id` - Zone ID.
- `subnet_id` - Subnet ID.
- `image_id` - Image ID.
- `instance_type` - Instance type name.
- `allocate_public_ipv4` - Whether to allocate a public IPv4.
- `ssh_pubkey` - SSH public key material.
- `security_group_ids` - Optional list of security group IDs.
- `root_volume` - Root volume configuration.

See `docs/import.md` for import caveats and minimal import configuration.

## Import

```bash
terraform import excloud_compute_instance.example <id>
```
