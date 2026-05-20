# terraform-provider-excloud

Terraform provider for Excloud.

## Resources

- `excloud_ssh_key`
- `excloud_compute_instance`
- `excloud_volume`
- `excloud_public_ipv4`
- `excloud_volume_attachment`
- `excloud_security_group`
- `excloud_security_group_rule`
- `excloud_security_group_binding`

## Data sources

- `excloud_compute_images`
- `excloud_instance_types`
- `excloud_subnets`

## Usage

```hcl
terraform {
  required_providers {
    excloud = {
      source  = "excloud-dev/excloud"
      version = "~> 0.1"
    }
  }
}

provider "excloud" {
  # Prefer environment variables or explicit attributes in production.
  # api_key = var.excloud_api_key
  # org_id  = var.excloud_org_id
}
```

## Authentication

The provider supports these attributes and corresponding environment variables:

- `api_key` / `API_KEY` / `EXCLOUD_API_KEY` / `EXCLOUD_ACCESS_TOKEN` / `ACCESS_TOKEN`
- `id_token` / `ID_TOKEN` / `EXCLOUD_ID_TOKEN`
- `account_id` / `ACCOUNT_ID` / `EXCLOUD_ACCOUNT_ID`
- `org_id` / `ORG_ID` / `EXCLOUD_ORG_ID`
- `compute_base_url` / `EXCLOUD_COMPUTE_BASE_URL`

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
