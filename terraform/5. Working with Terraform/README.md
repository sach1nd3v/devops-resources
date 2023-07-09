Terraform Commands
------------------

- Terraform CLI Docs: https://developer.hashicorp.com/terraform/cli
- `terraform init` Prepare your working directory for other command and downloads providers
- `terraform validate` Check whether the configuration is valid
- `terraform plan` Show changes required by the current configuration
- `terraform apply` Create or update infrastructure
- `terraform destroy` Destroy previously-created infrastructure
- `terraform fmt` Reformat your configuration in the standard style(canonical format)
- `terraform show` Show the current state or a saved plan
- `terraform providers` Show the providers required for this configuration
- `terraform provider mirror` used to mirror plugins form one directory to another directory
- `terraform output` Show output values from your root module
- `terraform refresh` Update the state to match remote systems
- `terraform graph`

Mutable vs Immutable infrastructure
-----------------------------------
- To avoid configuration drift we use immutable infrastructure
- Immutability makes easire to version the infrastructure and roll back and forward
- Terraform follows the immutability .
- When there is any change in an infrastructuer instance the terraform first destro old instance and creates new instance with new updates.
- Terraform blog : https://www.hashicorp.com/resources/what-is-mutable-vs-immutable-infrastructure

Configuration Drift
-------------------

Lifecycle Rules
---------------
- https://developer.hashicorp.com/terraform/tutorials/state/resource-lifecycle
- https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle
- `create_before_destroy ` Lets say we want to update a resource but dont want terraform to destro older resource before creating new one. Then we will add lifecycle meta argument to resource block as below
  
        resource "local_file" "pet" {
            filename = "/root/pets.txt"
            file_permission = "0700"
            content = "I love cats"
            lifecycle {
            create_before_destroy = true
            }
        }

        resource "local_sensitive_file" "name" {
            filename = "djjd"
            content = "djdj"
            lifecycle {
            prevent_destroy = true
            }
        }

- Use `ptrevent_destroy=true` to prevent resources accedently destroyed.
- Note This rules only prevent deletion from changes that are made to the configurationand subsequent apply. Resource still can be destroyed by using `terraform destroy` command.
- `ignore_changes` : This life-cycle rule when applied will prevent aresource being updated based upon a list of attributes that we define in alifecycle block.as below

        resource "aws_instance" "example" {
        # ...
        lifecycle {
            ignore_changes = [
            # Ignore changes to tags, e.g. because a management agent
            # updates these based on some ruleset managed elsewhere.
            tags,
            ]
        }
        }
- Now when changes made to these tags outsode from terraform, it will attempt to fix this on next apply
-  `ignore_changes=all` will make it to ignore any changes from outside of terraform.

Datasources
-----------
- Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.
- Documentation: https://developer.hashicorp.com/terraform/language/data-sources
- A data source is accessed via a special kind of resource known as a data resource, declared using a data block: as below

        resource "local_file" "pet" {
            filename = "/root/pets.txt"
            file_permission = "0700"
            content = "I love ${data.local_file.dogs.content}"
        }

        data "local_file" "dogs" {
        filename = "/root/dogs.txt"
        }

- Data sources also exports the attributes
- 
Meta Arguments
--------------
- https://medium.com/@neonforge/meta-arguments-in-terraform-unlocking-the-full-potential-of-infrastructure-as-code-de125c85c547
- https://blog.knoldus.com/meta-arguments-in-terraform/
- Meat arguments can be used in any resource blocks to change the behaviour of resource creation
- Like to create the may resources of same type
- Some if the meta argumens are as below
>- depends_on
>- count
>- for_each
>- provider
>- lifecycle

Count
-----
- https://developer.hashicorp.com/terraform/language/meta-arguments/count
- `count` is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type
- If a resource or module block includes a count argument whose value is a whole number, Terraform will create that many instances.
- The count meta-argument accepts a whole number, and creates that many instances of the resource or module. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.
- `main.tf`
  
        resource "local_file" "pet" {
            filename = var.filename
            count = 3
        }
- `variables.tf`
        
        variable "filename" {
            default="/root/pet.txt"
        }

- In above fashion terraform will create 3 files since filename is same it will create same file agin and again.
- To overcome above situation we can use list to specify filenames in variables like below

        #main.tf
        resource "local_file" "pet" {
            filename = var.filename[count.index]
            count = 3
        }
        ---
        #variables.tf
        variable "filename" {
            default=["/root/pet.txt", "/root/abc.txt","/root/hello.txt"]
        }
- We can modify to count to pickup the count dynamically from variables as below

        #main.tf
        resource "local_file" "pet" {
            filename = var.filename[count.index]
            count = length(var.filename)
        }
- count has some drawback. If we remove one file (that is not last). Then terraform will replace the all resources and destroy removed resouces.
- This is not ideal approach. Thats why we have for-each


for_each
--------
- https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
- If a resource or module block includes a for_each argument whose value is a `map ` or a `set` of strings, Terraform creates one instance for each member of that `map or set`.
- Note: A given resource or module block cannot use both count and for_each
- for_each is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.
- The for_each meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.
- Examples

        #main.tf
        resource "local_file" "pet" {
            filename=each.value
            for_each=var.filename
        }
        ----
        #variables.tf
        variable "filename" {
            type=set(string)
            default=["/root/pet.txt", "/root/abc.txt","/root/hello.txt"]
        }
- Similler way it work for map 

Version Constraints
------------------
- https://developer.hashicorp.com/terraform/language/expressions/version-constraintsWithout anyconfiguration, `terraform init` downloads the latest version of any provider plugin.
- Every provider plugin provides the code block how to use a specific version of provider.
- Look below code fro `local` provider

        terraform {
        required_providers {
            local = {
            source = "hashicorp/local"
            version = "2.4.0"
            }
        }
        }

        provider "local" {
        # Configuration options
        }


