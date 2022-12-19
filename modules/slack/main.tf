terraform {
  required_providers {
    slack = {
      source  = "pablovarela/slack"
      version = "~> 1.0"
    }
  }
  required_version = ">= 0.13"
}

# In this place we can export SLACK_TOKEN variable to our env (export SLACK_TOKEN=)
provider "slack" {}

# Create slack conversation in Slack (Worksapace codica-site-status)
resource "slack_conversation" "test" {
  name              = "${var.slack_project_name}-site-status"
  topic             = "Channel for PagerDuty Alerts"
  permanent_members = []
  is_private        = false
  adopt_existing_channel = true
}