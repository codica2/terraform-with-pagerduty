module "pagerduty" {
  source = "./modules/pagerduty"
  project_name = var.project_name
  slack_channel_id = module.slack.slack_channel_id
  slack_workspace_id = var.slack_workspace_id
}
module "slack" {
  source = "./modules/slack"
  slack_project_name = var.slack_project_name
}