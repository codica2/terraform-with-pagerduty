<h1 align="center">Terraform with Pagerduty</h1>

![](terraform-pagerduty-logo.png)

## Description

In this case, we will tell how to create a `PagerDuty` service via `Terraform`.  
`PagerDuty` is used to automate, orchestrate, and accelerate responses across your digital infrastructure.
[Read more about Pagerduty](https://support.pagerduty.com).
[Read more about Terraform](https://www.terraform.io).

## Folders hierarchy 

![](hierarchy.png) <br>

## Pagerduty module

We have a `modules` folder that includes 2 modules `slack` and `pagerduty`.  
Let's start with `pagerduty` module.  

```hcl
provider "pagerduty" {
    token = 123412441 # You can set the environment variable locally with the name PAGERDUTY_TOKEN=1234566788 for better security
}
```

Now will create a `service directory` for the project.  

```hcl
# Create service directory for project 
resource "pagerduty_service" "project_name" {
    name = "${var.project_name}"
    description = "Project ${var.project_name} status"
    escalation_policy = data.pagerduty_escalation_policy.main.id
    auto_resolve_timeout = 7200
    acknowledgement_timeout = "null"
}
```

**Important** we need to use `data` source, for example:  

```hcl
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
```

[Read more about data resources](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs).<br>
If you want to create integrations in your service directory, you must use this resource:<br>

```hcl
# Create PagerDuty integrations
resource "pagerduty_service_integration" "prometheus" {
  count = length(var.list_of_integration)
  vendor = element(data.pagerduty_vendor.integrations.*.id, count.index) # take vendor from data resource 
  service = pagerduty_service.project_name.id
  name = "${var.list_of_integration[count.index]} Integration"
}
```

If you want to configure orchestration for your events you need to set up this resource:  

```hcl
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
```

## Slack module

To create a slack channel to accept events from pagerduty you need to set up `slack` module. Example below:<br>

```hcl
provider "slack" {
    token = 123123123123 # You can set the environment variable locally with name SLACK_TOKEN=xoxb-123123123-12313 for better security
}
```

Create a channel in your workspace:<br>

```hcl
resource "slack_conversation" "test" {
  name              = "${var.slack_project_name}-site-status"
  topic             = "Channel for PagerDuty Alerts"
  permanent_members = []
  is_private        = false
  adopt_existing_channel = true
}
```

## Conclusion

In this case, we performed a set up of `PagerDuty` with `Slack` via Terraform.<br>
![](final-pic1.png)<br>
![](final-pic2.png)<br>

## License

Copyright © 2015-2022 Codica. It is released under the [MIT License](https://opensource.org/licenses/MIT).<br>

## About Codica

[![Codica logo](https://www.codica.com/assets/images/logo/logo.svg)](https://www.codica.com) <br>

The names and logos for Codica are trademarks of Codica.<br>

We love open-source software! See [our other projects](https://github.com/codica2) or [hire us](https://www.codica.com/) to design, develop, and grow your product.<br>
