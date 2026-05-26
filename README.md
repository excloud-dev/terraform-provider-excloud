# Excloud Terraform Provider

Terraform provider for Excloud compute, storage, networking, object-storage, DNS, and IAM resources.

Use it to provision virtual machines, block volumes, snapshots, public IPv4 reservations, security groups, SSH keys, DNS zones, S3-compatible buckets, and IAM service accounts and policies from Terraform.

## Resources

- `excloud_ssh_key`
- `excloud_compute_instance`
- `excloud_volume`
- `excloud_snapshot`
- `excloud_public_ipv4`
- `excloud_volume_attachment`
- `excloud_security_group`
- `excloud_security_group_rule`
- `excloud_security_group_binding`
- `excloud_bucket`
- `excloud_bucket_access_key`
- `excloud_dns_zone`
- `excloud_dns_record`
- `excloud_iam_service_account`
- `excloud_iam_policy`
- `excloud_iam_policy_binding`

## Data sources

- `excloud_compute_images`
- `excloud_instance_types`
- `excloud_subnets`
- `excloud_snapshots`
- `excloud_buckets`
- `excloud_bucket_usage`
- `excloud_dns_zones`
- `excloud_iam_service_accounts`
- `excloud_iam_policies`
- `excloud_iam_policy_bindings`

## Usage

```hcl
terraform {
  required_providers {
    excloud = {
      source  = "excloud-dev/excloud"
      version = "~> 0.4"
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

## Authentication

The provider uses the same credentials for compute, buckets, DNS, IAM, and all other resources/data sources. Resolution order is:

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
- `iam_base_url` / `EXCLOUD_IAM_BASE_URL`
- `dns_base_url` / `EXCLOUD_DNS_BASE_URL`

## Example

```hcl
resource "excloud_ssh_key" "main" {
  name       = "main-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "excloud_volume" "data" {
  name     = "app-data"
  zone_id  = 1
  size_gib = 20
}

resource "excloud_snapshot" "data" {
  volume_id = tonumber(excloud_volume.data.id)
}

resource "excloud_bucket" "assets" {
  name      = "my-assets-bucket"
  is_public = false
}

resource "excloud_dns_zone" "example" {
  name      = "example.com"
  zone_type = "public"
}

resource "excloud_dns_record" "www" {
  zone_name = excloud_dns_zone.example.name
  name      = "www"
  type      = "A"
  value     = "203.0.113.10"
  ttl       = 3600
}

resource "excloud_iam_service_account" "worker" {
  name = "terraform-worker"
}

resource "excloud_iam_policy" "compute_read" {
  name = "terraform-compute-read"

  policy_json = jsonencode({
    Version = "2024-03-05"
    Statements = [{
      Effect   = "Allow"
      Action   = ["compute:instance:list"]
      Resource = ["*"]
    }]
  })
}

resource "excloud_iam_policy_binding" "worker_compute_read" {
  policy_id          = tonumber(excloud_iam_policy.compute_read.id)
  service_account_id = tonumber(excloud_iam_service_account.worker.id)
}
```

## Build and test

```bash
./scripts/check.sh
```

Manual equivalent:

```bash
go test ./...
go test -tags=acc ./internal/provider -run TestAcc -count=0
go build -o terraform-provider-excloud
rm -f terraform-provider-excloud
```

## Local development override

Create a Terraform CLI config file, for example `/tmp/excloud.tfrc`:

```hcl
provider_installation {
  dev_overrides {
    "excloud-dev/excloud" = "/absolute/path/to/terraform-provider-excloud"
  }
  direct {}
}
```

Then run Terraform with:

```bash
TF_CLI_CONFIG_FILE=/tmp/excloud.tfrc terraform plan -input=false
```
