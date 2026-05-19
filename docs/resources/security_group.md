---
page_title: "excloud_security_group Resource - excloud"
description: |-
  Manages an Excloud security group.
---

# excloud_security_group

Manages a security group.

## Example Usage

```hcl
resource "excloud_security_group" "example" {
  name        = "example-sg"
  description = "Example security group"
}
```

## Arguments

- `name` - Security group name.
- `description` - Optional description.

## Import

```bash
terraform import excloud_security_group.example <id>
```
