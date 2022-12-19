# Configure the PagerDuty provider
terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "2.2.1"
    }
  }
}

provider "pagerduty" {}
# DATA
data "pagerduty_escalation_policy" "main" {
    name = "Main"
}

data "pagerduty_vendor" "integrations" {
  count = length(var.list_of_integration)
  name = element(var.list_of_integration[*], count.index)
}

data "pagerduty_priority" "p5" {
  name = "P5"
}

# Create service directory for project 
resource "pagerduty_service" "project_name" {
    name = "${var.project_name}"
    description = "Project ${var.project_name} status"
    escalation_policy = data.pagerduty_escalation_policy.main.id
    auto_resolve_timeout = 7200
    acknowledgement_timeout = "null"
}

# Create PagerDuty integrations
resource "pagerduty_service_integration" "prometheus" {
  count = length(var.list_of_integration)
  vendor = element(data.pagerduty_vendor.integrations.*.id, count.index)
  service = pagerduty_service.project_name.id
  name = "${var.list_of_integration[count.index]} Integration"
}

# Create event rule for service
resource "pagerduty_service_event_rule" "foo" {
  service  = pagerduty_service.project_name.id
  position = 0
  disabled = true

  conditions {
    operator = "and"

    subconditions {
      operator = "contains"

      parameter {
        value = "ECS-Exec StartSession"
        path  = "summary"
      }
    }
  }

  actions {

    annotate {
      value = "Someone connect to server" # Annotate for our Alert
    }

    severity {
      value = "info" # Set severity
    }

    priority {
      value = data.pagerduty_priority.p5.id # set priority for this event
    }

  }
}