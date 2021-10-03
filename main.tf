resource "aci_rest" "dnsProfile" {
  dn         = "uni/fabric/dnsp-${var.name}"
  class_name = "dnsProfile"
  content = {
    name = var.name
  }
}

resource "aci_rest" "dnsRsProfileToEpg" {
  dn         = "${aci_rest.dnsProfile.id}/rsProfileToEpg"
  class_name = "dnsRsProfileToEpg"
  content = {
    tDn = var.mgmt_epg_type == "oob" ? "uni/tn-mgmt/mgmtp-default/oob-${var.mgmt_epg_name}" : "uni/tn-mgmt/mgmtp-default/inb-${var.mgmt_epg_name}"
  }
}

resource "aci_rest" "dnsProv" {
  for_each   = { for prov in var.providers_ : prov.ip => prov }
  dn         = "${aci_rest.dnsProfile.id}/prov-[${each.value.ip}]"
  class_name = "dnsProv"
  content = {
    addr      = each.value.ip
    preferred = each.value.preferred == true ? "yes" : "no"
  }
}

resource "aci_rest" "dnsDomain" {
  for_each   = { for dom in var.domains : dom.name => dom }
  dn         = "${aci_rest.dnsProfile.id}/dom-${each.value.name}"
  class_name = "dnsDomain"
  content = {
    name      = each.value.name
    isDefault = each.value.default == true ? "yes" : "no"
  }
}
