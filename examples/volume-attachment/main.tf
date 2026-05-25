terraform {
  required_providers {
    excloud = {
      source = "excloud-dev/excloud"
    }
  }
}

# Uses provider attributes, environment variables, or ~/.exc/config from `exc login`.
provider "excloud" {}

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

resource "excloud_compute_instance" "host" {
  name                 = "tf-attachment-host"
  zone_id              = local.default_subnet.zone_id
  subnet_id            = local.default_subnet.id
  image_id             = local.ubuntu_image.id
  instance_type        = local.micro_type.name
  allocate_public_ipv4 = false

  root_volume = {
    name     = "tf-attachment-host-root"
    size_gib = 10
  }
}

resource "excloud_volume" "data" {
  name     = "tf-attachment-data"
  zone_id  = local.default_subnet.zone_id
  size_gib = 10
}

# Attaches the standalone data volume to the host VM. Attachment state is
# managed entirely through Terraform; detach happens on destroy or when
# either side is removed.
resource "excloud_volume_attachment" "data" {
  vm_id     = tonumber(excloud_compute_instance.host.id)
  volume_id = tonumber(excloud_volume.data.id)
}

output "volume_state" {
  value = excloud_volume_attachment.data.volume_state
}

output "attachment_state" {
  value = excloud_volume_attachment.data.attachment_state
}

output "device_path" {
  value = excloud_volume_attachment.data.device_path
}
