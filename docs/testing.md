# Testing the Excloud Terraform provider

## Local deterministic checks

Run the same check used by CI:

```bash
./scripts/check.sh
```

This regenerates provider code from OpenAPI metadata, formats Go files, runs unit tests, builds the provider binary, removes the binary, and checks generated-code cleanliness when inside a Git work tree.

## Acceptance tests

Acceptance tests are intentionally opt-in because they talk to the live Excloud API.

Compile-only check:

```bash
go test -tags=acc ./internal/provider -run TestAcc -count=0
```

Live data-source tests:

```bash
TF_ACC=1 go test -tags=acc ./internal/provider -run TestAccDataSources -count=1
```

DNS data-source tests are gated separately because they require a DNS API token/policy:

```bash
TF_ACC=1 TF_ACC_DNS=1 go test -tags=acc ./internal/provider -run TestAccDNSDataSources -count=1
```

Live create/destroy tests for low-cost resources:

```bash
TF_ACC=1 TF_ACC_CREATE=1 go test -tags=acc ./internal/provider -run 'TestAcc(SSHKey|SecurityGroup)' -count=1
```

Billable create/destroy tests:

```bash
TF_ACC=1 TF_ACC_CREATE=1 TF_ACC_BILLABLE=1 go test -tags=acc ./internal/provider -run 'TestAcc(Volume|PublicIPv4|Snapshot)' -count=1
```

Object-storage and DNS create/destroy tests:

```bash
TF_ACC=1 TF_ACC_CREATE=1 go test -tags=acc ./internal/provider -run 'TestAccBucket' -count=1
TF_ACC=1 TF_ACC_CREATE=1 TF_ACC_DNS=1 go test -tags=acc ./internal/provider -run TestAccDNSZoneAndRecord -count=1
```

The tests build a local `terraform-provider-excloud` binary, use Terraform dev overrides, and remove the binary during cleanup.

## Cleanup helper

If an acceptance test is interrupted, inspect matching resources with a dry run:

```bash
scripts/reap-tf-acc.sh --prefix tf-acc
```

If the output only includes resources that should be deleted, execute cleanup:

```bash
scripts/reap-tf-acc.sh --prefix tf-acc --apply
```

The helper is conservative: it only matches names with the chosen prefix, skips attached public IPv4s, skips `IN_USE` volumes, and defaults to dry-run mode.

## Safety rules

- Do not run VM acceptance tests by default.
- Keep billable tests behind explicit environment flags.
- Use unique names for live resources.
- Always destroy live resources after testing.
- Do not print `.env` or token values in logs.
