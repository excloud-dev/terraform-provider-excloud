---
page_title: "excloud_security_group_binding Resource - excloud"
description: |-
  Binds an Excloud security group to a network interface.
---

# excloud_security_group_binding

Binds a security group to a network interface.

## Example Usage

```hcl
resource "excloud_security_group_binding" "example" {
  security_group_id = tonumber(excloud_security_group.example.id)
  interface_id      = 1234
}
```

## Arguments

- `security_group_id` - Security group ID.
- `interface_id` - Network interface ID.

## Import

Composite ID format is `security_group_id:interface_id`.

```bash
terraform import excloud_security_group_binding.example 123:456
```
