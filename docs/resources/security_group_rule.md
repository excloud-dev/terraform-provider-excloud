---
page_title: "excloud_security_group_rule Resource - excloud"
description: |-
  Manages a rule in an Excloud security group.
---

# excloud_security_group_rule

Manages a security group rule.

## Example Usage

```hcl
resource "excloud_security_group_rule" "ssh" {
  security_group_id = tonumber(excloud_security_group.example.id)
  is_ingress        = true
  protocol          = "TCPv4"
  port_range        = "22"
  cidr              = "0.0.0.0/0"
  description       = "SSH"
}
```

## Arguments

- `security_group_id` - Parent security group ID.
- `is_ingress` - Whether the rule is ingress.
- `protocol` - Protocol such as `TCPv4`.
- `port_range` - Port range or `ANY`.
- `cidr` - CIDR block.
- `description` - Optional description.

## Import

```bash
terraform import excloud_security_group_rule.ssh <id>
```
