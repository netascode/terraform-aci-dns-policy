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

  name          = "DNS1"
  mgmt_epg      = "oob"
  mgmt_epg_name = "OOB1"
  providers_ = [{
    ip        = "10.1.1.1"
    preferred = true
  }]
  domains = [{
    name    = "cisco.com"
    default = true
  }]
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

data "aci_rest" "dnsRsProfileToEpg" {
  dn = "${data.aci_rest.dnsProfile.id}/rsProfileToEpg"

  depends_on = [module.main]
}

resource "test_assertions" "dnsRsProfileToEpg" {
  component = "dnsRsProfileToEpg"

  equal "tDn" {
    description = "tDn"
    got         = data.aci_rest.dnsRsProfileToEpg.content.tDn
    want        = "uni/tn-mgmt/mgmtp-default/oob-OOB1"
  }
}

data "aci_rest" "dnsProv" {
  dn = "${data.aci_rest.dnsProfile.id}/prov-[10.1.1.1]"

  depends_on = [module.main]
}

resource "test_assertions" "dnsProv" {
  component = "dnsProv"

  equal "addr" {
    description = "addr"
    got         = data.aci_rest.dnsProv.content.addr
    want        = "10.1.1.1"
  }

  equal "preferred" {
    description = "preferred"
    got         = data.aci_rest.dnsProv.content.preferred
    want        = "yes"
  }
}

data "aci_rest" "dnsDomain" {
  dn = "${data.aci_rest.dnsProfile.id}/dom-cisco.com"

  depends_on = [module.main]
}

resource "test_assertions" "dnsDomain" {
  component = "dnsDomain"

  equal "name" {
    description = "name"
    got         = data.aci_rest.dnsDomain.content.name
    want        = "cisco.com"
  }

  equal "isDefault" {
    description = "isDefault"
    got         = data.aci_rest.dnsDomain.content.isDefault
    want        = "yes"
  }
}
