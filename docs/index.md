---
page_title: "Excloud Provider"
description: |-
  Terraform provider for Excloud compute, storage, networking, and object-storage resources.
---

# Excloud Provider

The Excloud provider manages Excloud infrastructure through the Excloud APIs. It currently supports compute instances, block volumes, snapshots, public IPv4s, security groups, SSH keys, DNS zones, and S3-compatible buckets.

## Example Usage

```hcl
terraform {
  required_providers {
    excloud = {
      source  = "excloud-dev/excloud"
      version = "0.2.1"
    }
  }
}

provider "excloud" {
  # Optional. If omitted, the provider uses environment variables or
  # ~/.exc/config from `exc login` / the selected exc account and org.
  # api_key = var.excloud_api_key
  # org_id  = var.excloud_org_id
}
```

For local development only, `.env` loading can be enabled explicitly:

```hcl
provider "excloud" {
  load_dotenv = true
}
```

## Authentication

The provider uses the same resolved credentials for every resource and data source, including compute, buckets, and DNS. Resolution order is:

1. Explicit provider attributes.
2. Environment variables.
3. `~/.exc/config`, as written by the `exc` CLI. When this fallback is used, the provider reads `default_acc`, `default_org`, that account's `id_token`, and that org's `access_token`.

Supported attributes and corresponding environment variables:

- `api_key` / `API_KEY` / `EXCLOUD_API_KEY` / `EXCLOUD_ACCESS_TOKEN` / `ACCESS_TOKEN` / selected `~/.exc/config` org access token
- `id_token` / `ID_TOKEN` / `EXCLOUD_ID_TOKEN` / selected `~/.exc/config` account ID token
- `account_id` / `ACCOUNT_ID` / `EXCLOUD_ACCOUNT_ID` / `~/.exc/config` `default_acc`
- `org_id` / `ORG_ID` / `EXCLOUD_ORG_ID` / `~/.exc/config` `default_org`
- `compute_base_url` / `EXCLOUD_COMPUTE_BASE_URL`
- `buckets_base_url` / `EXCLOUD_BUCKETS_BASE_URL`
- `dns_base_url` / `EXCLOUD_DNS_BASE_URL`

## Available Resources

- `excloud_compute_instance`
- `excloud_volume`
- `excloud_snapshot`
- `excloud_public_ipv4`
- `excloud_volume_attachment`
- `excloud_security_group`
- `excloud_security_group_rule`
- `excloud_security_group_binding`
- `excloud_ssh_key`
- `excloud_bucket`
- `excloud_bucket_access_key`
- `excloud_dns_zone`
- `excloud_dns_record`

## Available Data Sources

- `excloud_compute_images`
- `excloud_instance_types`
- `excloud_subnets`
- `excloud_snapshots`
- `excloud_buckets`
- `excloud_bucket_usage`
- `excloud_dns_zones`

## Safety

Some resources create billable infrastructure, including compute instances, volumes, snapshots, public IPv4 reservations, and object-storage buckets. Review plans carefully before applying. Sensitive values such as bucket secret access keys are stored in Terraform state.
