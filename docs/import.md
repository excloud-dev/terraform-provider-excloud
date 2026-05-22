# Importing existing Excloud resources

This page documents the import behavior that has been live-validated for the generated Terraform provider.

## First principles

Terraform import has two separate pieces:

1. **Remote object identity** — the ID passed to `terraform import`, e.g. a VM ID.
2. **Desired configuration** — the `.tf` resource block Terraform will compare against refreshed remote state after import.

Import can only be clean when the configuration contains values that either:

- are recoverable from the API during refresh, or
- intentionally match the remote object.

Some create-time inputs are not returned by the API, so the provider cannot reconstruct them after import. Do not put those fields in import config unless you intentionally want Terraform to replace the VM.

## `excloud_compute_instance`

Live validated on 2026-05-18:

- VM `10842`: import + refresh succeeded.
- VM `10845`: import + clean post-import plan + destroy from imported state succeeded.

### Minimal import config shape

Use this shape for an existing VM:

```hcl
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
```

Then run:

```bash
terraform import excloud_compute_instance.imported <vm_id>
terraform plan -input=false
```

A clean import should produce:

```text
No changes. Your infrastructure matches the configuration.
```

### Fields to omit unless you intend replacement

Omit these from imported VM config unless you intentionally want a replacement or already know they exactly match state semantics:

- `root_password` — write-only/create-time input; not returned by API.
- `user_data` — create-time input; not returned by API.
- `root_volume.name` — the API currently auto-generates root volume names and may not preserve the requested create-time name.
- `ssh_pubkey` — only include it if the API returns the same normalized value and you want Terraform to enforce it.

### Fields the provider hydrates during import refresh

When prior imported state is missing values, the provider attempts to fill safe state from read APIs:

- `image_id` by matching VM `image_name` against `excloud_compute_images` / image list.
- `allocate_public_ipv4` from whether the VM has a public IPv4.
- `root_volume.size_gib` from `VolumeGet(root_volume_id).size_bytes`.
- `security_group_ids` from security group bindings on VM interface IDs.

Terraform configuration must still contain desired values for required fields. Hydration prevents state conversion/plan drift for values the provider can safely recover.

### Destroying from imported state

Destroy from imported state was live-validated. VM delete waits for `TERMINATED` before Terraform proceeds, so security group bindings have time to clear before parent security groups are destroyed.

If you imported a VM into a second workspace while it is also managed by another Terraform state, remove it from the old state first:

```bash
terraform state rm excloud_compute_instance.demo
```

Only do this when you are sure the second workspace should own the VM.

## `excloud_volume`, `excloud_snapshot`, and object-storage resources

These resources support straightforward import by their remote identifiers:

```bash
terraform import excloud_volume.data <volume_id>
terraform import excloud_snapshot.data <snapshot_id>
terraform import excloud_bucket.assets <bucket_name>
terraform import excloud_bucket_access_key.automation <access_key_id>
terraform import excloud_dns_zone.example <zone_name>
```

For `excloud_bucket_access_key`, importing cannot recover `secret_access_key`; Excloud returns that value only during key creation.
