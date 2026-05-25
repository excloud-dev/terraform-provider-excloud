terraform {
  required_providers {
    excloud = {
      source  = "excloud-dev/excloud"
      version = "0.2.1"
    }
  }
}

provider "excloud" {
  # Optional. If omitted, the provider falls back to environment variables or
  # ~/.exc/config from `exc login`, including the selected account and org.
  # api_key = var.excloud_api_key
  # org_id  = var.excloud_org_id

  # Local development only: opt in if you want the provider to walk upward and
  # load a .env file. Production usage should prefer explicit env vars or
  # provider attributes.
  # load_dotenv = true
}

data "excloud_compute_images" "available" {}

data "excloud_instance_types" "available" {}

data "excloud_subnets" "zone_1" {
  zone_id = 1
}

locals {
  ubuntu_image = one([
    for image in data.excloud_compute_images.available.images : image
    if image.name == "ubuntu-24.04-latest"
  ])

  micro_type = one([
    for instance_type in data.excloud_instance_types.available.instance_types : instance_type
    if instance_type.name == "t1a.micro"
  ])

  default_subnet = one([
    for subnet in data.excloud_subnets.zone_1.subnets : subnet
    if subnet.name == "DEFAULT"
  ])
}

resource "excloud_ssh_key" "demo" {
  name       = "tf-generated-demo"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDummyExampleKeyDoNotApply terraform-generated@example"
}

resource "excloud_security_group" "demo" {
  name        = "tf-generated-demo-sg"
  description = "Generated Terraform provider example security group"
}

# Applying this creates billable infrastructure. It is present to prove the
# generated compute instance schema/plan path, not as a safe default apply.
resource "excloud_compute_instance" "demo" {
  name                 = "tf-generated-vm"
  zone_id              = local.default_subnet.zone_id
  subnet_id            = local.default_subnet.id
  image_id             = local.ubuntu_image.id
  instance_type        = local.micro_type.name
  allocate_public_ipv4 = false
  ssh_pubkey           = excloud_ssh_key.demo.public_key
  security_group_ids   = [tonumber(excloud_security_group.demo.id)]

  root_volume = {
    name     = "tf-generated-vm-root"
    size_gib = 10
  }
}

output "selected_image" {
  value = local.ubuntu_image.name
}

output "selected_instance_type" {
  value = local.micro_type.name
}

output "selected_subnet_id" {
  value = local.default_subnet.id
}

output "vm_id" {
  value = excloud_compute_instance.demo.id
}
