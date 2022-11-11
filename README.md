<h1 align="center">Terraform with Pagerduty</h1>

![](terraform-pagerduty-logo.png)

## Description 
In this case, we will told about how to create `PagerDuty` service via `Terraform`.  
`PagerDuty` uses for automate, orchestrate, and accelerate responses across your digital infrastructure.
[Read more about Pagerduty](https://support.pagerduty.com) . 
[Read more about Terraform](https://www.terraform.io) . 

## Hierarchy of our folders  
![](hierarchy.png) .<br>
In this case we have `modulues` folder which include 2 modules `slack` and `pagerduty`.  
We will start from `pagerduty` module.  
```yaml
provider "pagerduty" {
    token = 123412441 # You can set environment variable locally with name PAGERDUTY_TOKEN=1234566788 for better security
}
```