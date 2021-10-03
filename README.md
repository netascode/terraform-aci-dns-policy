<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-dns-policy/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-dns-policy/actions/workflows/test.yml)

# Terraform ACI DNS Policy Module

Manages ACI DNS Policy

Location in GUI:
`Fabric` » `Fabric Policies` » `Policies` » `Global` » `DNS Profiles`

## Examples

```hcl
module "aci_dns_policy" {
  source  = "netascode/dns-policy/aci"
  version = ">= 0.0.1"

  name          = "DNS1"
  mgmt_epg_type = "oob"
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

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | DNS policy name. | `string` | n/a | yes |
| <a name="input_mgmt_epg_type"></a> [mgmt\_epg\_type](#input\_mgmt\_epg\_type) | Management endpoint group type. | `string` | `"inb"` | no |
| <a name="input_mgmt_epg_name"></a> [mgmt\_epg\_name](#input\_mgmt\_epg\_name) | Management endpoint group name. | `string` | `""` | no |
| <a name="input_providers_"></a> [providers\_](#input\_providers\_) | List of DNS providers. Default value `preferred`: false. | <pre>list(object({<br>    ip        = string<br>    preferred = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_domains"></a> [domains](#input\_domains) | List of domains. Default value `default`: false. | <pre>list(object({<br>    name    = string<br>    default = optional(bool)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `dnsProfile` object. |
| <a name="output_name"></a> [name](#output\_name) | DNS policy name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.dnsDomain](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.dnsProfile](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.dnsProv](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.dnsRsProfileToEpg](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->