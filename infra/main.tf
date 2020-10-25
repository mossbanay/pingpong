module "client-ap-southeast-2" {
  source = "./client"
  region = "ap-southeast-2"
}

module "client-eu-west-1" {
  source = "./client"
  region = "eu-west-1"
}

resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      ip_addrs = [
        module.client-ap-southeast-2.ip,
        module.client-eu-west-1.ip,
      ]
  })
  filename        = "inventory"
  file_permission = 644
}
