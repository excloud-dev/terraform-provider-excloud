terraform {
  required_providers {
    excloud = {
      source = "excloud-dev/excloud"
    }
  }
}

# Uses provider attributes, environment variables, or ~/.exc/config from `exc login`.
provider "excloud" {}

resource "excloud_security_group" "web" {
  name        = "tf-generated-web-sg"
  description = "Allow inbound HTTP and SSH"
}

resource "excloud_security_group_rule" "allow_ssh" {
  security_group_id = tonumber(excloud_security_group.web.id)
  is_ingress        = true
  protocol          = "TCPv4"
  port_range        = "22"
  cidr              = "0.0.0.0/0"
  description       = "SSH from anywhere"
}

resource "excloud_security_group_rule" "allow_http" {
  security_group_id = tonumber(excloud_security_group.web.id)
  is_ingress        = true
  protocol          = "TCPv4"
  port_range        = "80,443"
  cidr              = "0.0.0.0/0"
  description       = "HTTP and HTTPS from anywhere"
}

# Binds the security group to a network interface. Replace interface_id with
# a real interface ID from `exc compute get <vm-id>` or excloud_compute_instance.interfaces.
# Commented out by default because it requires an existing interface.
# resource "excloud_security_group_binding" "web" {
#   security_group_id = tonumber(excloud_security_group.web.id)
#   interface_id      = 12345
# }

output "security_group_id" {
  value = excloud_security_group.web.id
}
