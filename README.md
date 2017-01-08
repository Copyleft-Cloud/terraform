#### Disclaimer
This Terraform project is part of Copyleft Cloud, an open sourced journey from the practitioners at Copyleft.io

---

# Terraform
Terraform is a tool for building, changing, and versioning infrastructure. We're going to use Terraform to integrate with service providers such as DigitalOcean and AWS to provision and manage our infrastructure as code.

## Overview
When thinking about Infrastructure as a Service (IaaS) and using Infrastructure as Code to achieve that objective we are concerned with thinking about the "Configuration" and "State" of the things we manage... how we use patterns... and the separation of roles (e.g. single role per node). And while we will often reuse patterns and roles to manage the “Configuration" in a consistent manner, we don't dare intermingle the "State" between devices.

So, when thinking about "Platform as a Service" (PaaS) and how best to implement we should approach it with a similar mindset as IaaS considering Configuration, State, and the Separation of Responsibility.

```
Configuration (noun)
an arrangement of elements in a particular form, figure, or combination.

State (noun)
the particular condition that someone or something is in at a specifc time.
```

## Summary
Per our good practices, we are wanting to manage configuration and state separately for each environment as well as provider.  As we will be using both DigitalOcean and AWS as Cloud Hosting providers for our operations and execution environments, we'll set up our directory accordingly to separate these contexts.


The Big Picture...
```
/
  /global
    secret.tfvars         # Keys, Credentials, etc
    global.tfvars         # Global Variables

  /modules                # Modules Directory
    /aws                  # AWS Modules
    /do                   # DigitalOcean Modules

  /provider-aws           # AWS Provider
    /env-ops              # Operations (OPS) Environment
      device-<role1>.tf   # Device (e.g. EC2 Instance)
      device-<role2>.tf   # Device (e.g. EC2 Instance)
      device-<role3>.tf   # Device (e.g. EC2 Instance)
      network.tf          # Network (e.g. VPC, Subnets, Gateways, Routes)
      security.tf         # Security (e.g. Security Groups)
      operations.tfvars   # Operations Environment Variables
      secret.tfvars       # Symlinked from Global
      global.tfvars       # Symlinked from Global

  /provider-do            # DigitalOcean Provider
    /env-svc              # Service (SVC) Environment
      device-<role1>.tf   # Device (e.g. Droplet Instance)
      device-<role2>.tf   # Device (e.g. Droplet Instance)
      device-<role3>.tf   # Device (e.g. Droplet Instance)    
      network.tf          # Network (e.g. Private Network, DNS, IPs)
      service.tfvars      # Service Environment Variables
      secret.tfvars       # Symlinked from Global
      global.tfvars       # Symlinked from Global

```


Thus, if we need to manage additional providers and subsequent environments, we have a neat and organized project directory where we can manage those artifacts.  Here are a few good tips that we've implemented based on our experience...

#### TIP 1: Limit the Blast Radius
Managing state (.tfstate) separately for each environment removes a substantial amount of risk and limits the blast radius of our infrastructure changes.  As you can see above we are doing this by provider (AWS, DO) and by environment.

#### TIP 2: Separate your Concerns
Note that within each environment we are separating our concerns (e.g. Devices, Network, Security, etc) so that it is more straightforward to develop and maintain our code base.

When implementing infrastructure as code... code commits and pull requests will most likely become real changes to your platform.  Make it as simple as possible for yourself and your team to reason about your platform, identify and manage the risk of  those changes.

#### TIP 3: Symlink Global Files
Note that we've symlinked a few files (.tfvars) from a global directory down into our specific provider environments... this allows us to use global variables in addition to the local variable files (.tfvars) per environment.  This helps to keep our terraform project DRY (don't repeat yourself) and can help with reusability and consistency across contexts.

#### TIP 4: Modules for Consistency across Environments
Note that we've got a modules directory. This is where we will create some reusable modules that we can leverage for consistency across environments for a provider. This helps to keep our terraform project DRY (don't repeat yourself) and can help with reusability and consistency across environments.
