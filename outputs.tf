output "dn" {
  value       = aci_rest.dnsProfile.id
  description = "Distinguished name of `dnsProfile` object."
}

output "name" {
  value       = aci_rest.dnsProfile.content.name
  description = "DNS policy name."
}
