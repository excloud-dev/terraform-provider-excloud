---
page_title: "excloud_volume_attachment Resource - excloud"
description: |-
  Attaches an Excloud block volume to a compute instance.
---

# excloud_volume_attachment

Attaches a block volume to a compute instance.

## Example Usage

```hcl
resource "excloud_volume_attachment" "example" {
  vm_id     = tonumber(excloud_compute_instance.example.id)
  volume_id = tonumber(excloud_volume.example.id)
}
```

## Arguments

- `vm_id` - Compute instance ID.
- `volume_id` - Volume ID.

## Import

Composite ID format is `vm_id:volume_id`.

```bash
terraform import excloud_volume_attachment.example 123:456
```
