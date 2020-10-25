module "client-ap-southeast-2" {
  source = "./client"
  region = "ap-southeast-2"
}

module "client-eu-west-1" {
  source = "./client"
  region = "eu-west-1"
}

module "server-ap-southeast-2" {
  source = "./client"
  region = "ap-southeast-2"
}

resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      client_ip_addrs = [
        module.client-ap-southeast-2.ip,
        module.client-eu-west-1.ip,
      ],
      server_ip_addrs = [
        module.server-ap-southeast-2.ip,
      ]
  })
  filename        = "inventory"
  file_permission = 644
}
