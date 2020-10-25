module "client-ap-northeast-1" {
  source = "./client"
  region = "ap-northeast-1"
}
module "client-ap-southeast-1" {
  source = "./client"
  region = "ap-southeast-1"
}
module "client-ap-southeast-2" {
  source = "./client"
  region = "ap-southeast-2"
}
module "client-ca-central-1" {
  source = "./client"
  region = "ca-central-1"
}
module "client-eu-central-1" {
  source = "./client"
  region = "eu-central-1"
}
module "client-eu-west-1" {
  source = "./client"
  region = "eu-west-1"
}
module "client-eu-west-2" {
  source = "./client"
  region = "eu-west-2"
}
module "client-eu-west-3" {
  source = "./client"
  region = "eu-west-3"
}
module "client-us-east-1" {
  source = "./client"
  region = "us-east-1"
}
module "client-us-east-2" {
  source = "./client"
  region = "us-east-2"
}
module "client-us-west-1" {
  source = "./client"
  region = "us-west-1"
}


module "server-ap-southeast-2" {
  source = "./client"
  region = "ap-southeast-2"
}

resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      client_ip_addrs = [
module.client-ap-northeast-1.ip,
module.client-ap-southeast-1.ip,
module.client-ap-southeast-2.ip,
module.client-ca-central-1.ip,
module.client-eu-central-1.ip,
module.client-eu-west-1.ip,
module.client-eu-west-2.ip,
module.client-eu-west-3.ip,
module.client-us-east-1.ip,
module.client-us-east-2.ip,
module.client-us-west-1.ip,

      ],
      server_ip_addrs = [
        module.server-ap-southeast-2.ip,
      ]
  })
  filename        = "inventory"
  file_permission = 644
}

resource "local_file" "ServerSummary" {
  content = templatefile("summary.tmpl",
    {
ap-northeast-1-ip = module.client-ap-northeast-1.ip,
ap-southeast-1-ip = module.client-ap-southeast-1.ip,
ap-southeast-2-ip = module.client-ap-southeast-2.ip,
ca-central-1-ip = module.client-ca-central-1.ip,
eu-central-1-ip = module.client-eu-central-1.ip,
eu-west-1-ip = module.client-eu-west-1.ip,
eu-west-2-ip = module.client-eu-west-2.ip,
eu-west-3-ip = module.client-eu-west-3.ip,
us-east-1-ip = module.client-us-east-1.ip,
us-east-2-ip = module.client-us-east-2.ip,
us-west-1-ip = module.client-us-west-1.ip,

  })
  filename        = "summary.csv"
  file_permission = 644
}
