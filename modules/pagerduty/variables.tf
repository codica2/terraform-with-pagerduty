variable "project_name" {}
variable "slack_channel_id" {}
variable "slack_workspace_id" {}
variable "list_of_integration" {
  type = list(string)
  default = [ "Prometheus", "GitLab", "Cloudwatch", "Custom Event Transformer" ]
}