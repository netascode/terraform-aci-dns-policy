terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name = "DNS1"
}

data "aci_rest" "dnsProfile" {
  dn = "uni/fabric/dnsp-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "dnsProfile" {
  component = "dnsProfile"

  equal "name" {
    description = "name"
    got         = data.aci_rest.dnsProfile.content.name
    want        = module.main.name
  }
}
