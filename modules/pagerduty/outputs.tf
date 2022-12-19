output "pagerduty_vendor" {
  value = data.pagerduty_vendor.integrations.*.name
}
output "pagerduty_integrations_ids" {
  value = pagerduty_service_integration.prometheus.*.id
}
output "pagerduty_integrations_integration_keys" {
  value = pagerduty_service_integration.prometheus.*.integration_key
}
output "pagerduty_integrations_html_urls" {
  value = pagerduty_service_integration.prometheus.*.html_url
}
output "pagerduty_integration_email" {
  value = pagerduty_service_integration.prometheus.*.integration_email
}
# output "pagerduty_integration_names" {
#   value = pagerduty_service_integration.prometheus.name
# }