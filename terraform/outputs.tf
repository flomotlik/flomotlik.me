output "zone_id" {
  value       = aws_route53_zone.flomotlik_me.zone_id
  description = "Route 53 hosted zone id for flomotlik.me"
}

output "name_servers" {
  value       = aws_route53_zone.flomotlik_me.name_servers
  description = "Must match what the registrar has, or the zone is not authoritative"
}
