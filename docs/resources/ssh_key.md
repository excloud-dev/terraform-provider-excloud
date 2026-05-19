---
page_title: "excloud_ssh_key Resource - excloud"
description: |-
  Manages an Excloud SSH public key.
---

# excloud_ssh_key

Manages an SSH public key.

## Example Usage

```hcl
resource "excloud_ssh_key" "example" {
  name       = "example-key"
  public_key = "ssh-ed25519 AAAA... user@example"
}
```

## Arguments

- `name` - SSH key name.
- `public_key` - Public key material.

## Import

```bash
terraform import excloud_ssh_key.example <id>
```
