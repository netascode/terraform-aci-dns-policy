module "aci_dns_policy" {
  source = "netascode/dns-policy/aci"

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
