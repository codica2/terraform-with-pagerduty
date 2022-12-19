output "slack_project_name" {
  value = var.slack_project_name
}
output "pagerduty_integrations_id" {
  value = module.pagerduty.pagerduty_integrations_ids
}
output "pagerduty_integrations_integration_keys" {
  value = module.pagerduty.pagerduty_integrations_integration_keys
}
output "pagerduty_integrations_html_urls" {
  value = module.pagerduty.pagerduty_integrations_html_urls
}
output "pagerduty_integration_email" {
  value = module.pagerduty.pagerduty_integration_email
}