# terraform-turtles

> Illustrate abstracting details with Terraform modules.

## Summary

In this repo, I illustrate the following:

1. Higher-level Terraform modules alleviate the burden of gritty details by applying reasonable defaults and calling lower-level modules.
1. As the level of abstraction increases (indicated by incrementing the module number), the quantity of gritty details decrease because the lower-level modules handle those lower-lever details—alleviates burden.
1. This workflow also illustrates the inverse—that is, as you decrease abstration, you increase the quantity of details—more arduous.

For example consider the higher-level _mod3_ module compared to the lower-level _mod2_ module:

```hcl
# mod3/main.tf
variable "config" {
  type = object({
    detail3 = optional(string, "reasonable mod3 default")
  })
  default = {} # defaults are good enough--yay!
}
# [...]
module "mod2" {
  source = "../mod2"
  config = var.config
}
# [...]
```
```hcl
# mod2/main.tf
variable "config" {
  type = object({
    detail2 = optional(string, "reasonable mod2 default")
    detail3 = string
  })
}
# [...]
```

**Observation:** Notice that you don't need to understand _detail2_ detail to call _mod2_ module because mod2 sets detail2 to _reasonable mod2 default_ default.

## Getting started

To get started, run the ordered sequence of steps.

1. Install Terraform—see [_Install Terraform_](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) page.

1. Get this code.

   ```bash
   git clone git@github.com:mbigras/terraform-turtles.git
   cd terraform-turtles
   ```

1. Initialize Terraform.

   ```bash
   terraform init
   ```

   Your output should look like the following:

   ```
   $ terraform init
   
   Initializing the backend...
   Initializing modules...
   - mod3 in mod3
   - mod3.mod2 in mod2
   - mod3.mod2.mod1 in mod1
   
   Initializing provider plugins...
   
   Terraform has been successfully initialized!
   [...]
   ```
   **Observation:** Notice that mod3 calls mod2 which calls mod1.

1. Automatically, plan and apply Terraform.

   ```bash
   terraform apply -auto-approve
   ```

   Your output should look like the following:

   ```
   $ terraform apply -auto-approve
   [...]
   Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
   
   Outputs:
   
   mod3 = {
     "config" = {
       "detail3" = "reasonable mod3 default"
     }
     "mod2" = {
       "config" = {
         "detail2" = "reasonable mod2 default"
         "detail3" = "reasonable mod3 default"
       }
       "mod1" = {
         "config" = {
           "detail1" = "reasonable mod1 default"
           "detail2" = "reasonable mod2 default"
           "detail3" = "reasonable mod3 default"
         }
       }
     }
   }
   ```

   Consider the following:

   1. **Observation:** Notice that you didn't need to understand _detail1_, _detail2_, or _detail3_ details to run the root Terraform module.
   1. **Insight:** The root module is a more abstract and less arduous root module because you don't need to set many variables because _mod3_, _mod2_, and _mod1_ lower-level Terraform modules each applied reasonable defaults and called further lower-level module.
