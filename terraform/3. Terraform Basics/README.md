Using Terraform Providers
-----------------------

-  Documentation: https://developer.hashicorp.com/terraform/language/providers
- When we run `terraform init` terraform downloads the plugins for the provider used by configuration.
- This can be plugin for cloud providers or a local provider.
- Ther are `official`, `partner` and `community` providers.
- `terrafom init` is safe command and can be run may times.
- The plugins are installed in hidden dicrectorty `.terraform` in the wokring directory containing the configuration files.
- Plugins have following formates

        <registryName>/<org_name>/<Type of provider>


Configuration Directory
-----------------------
- We Can have as mamy configuration file in a single directory
- A configuration file can have mamny blocks.
- Common convention is to have a main.tf , variables.tf, outputs.tf  and providers .tf
- `main.tf`is the main configuration file containing resource definition
- `variables.tf` contains the variable declartion
- `outputs.tf` contains the outputs from the resouces
- `providers.tf` contains the providers definition


Multiple Providers
------------------
- We can use multiple providers in same configuration file
- For ecample using random provider (logical provider)
- random provider is logical provider it dosplays the result on console

Using Input Variables
---------------------

-  Documentation: https://developer.hashicorp.com/terraform/language/values/variables
- To provide abstraction to `main.tf` file we will use variables for arguments values and will seperate the variables in `variables.tf` file.
- variable syntax is as follows

        variable "<variable_name>" {
            default="<default value>"
        }
        variable "filename" {
            default="I love pets"
        }
- now update the `main.tf` as follows

        resource "local_file" "pet" {
            filename=var.filename
            content=var.content
        }

- This apply resuability of code using variables

Understanding the variable block
--------------------------------
- There are some attributes to a variable as follows

        1. default
        2. type (optiona)
        3. description (optional)

- types can be string, integers, bool and any(by default)
- type enforces the variable type
- Terraform also supports list, map, object tuple , set types
- List variable can be defined like below and it can be accses using index startig with zero

        variable "prefix" {
                default = ["Mr", "Ms", "Sir"]
                type = list
        }

- and can be accessed as below

        resources "random_pet" "my-pet" {
                prefix = var.prefix[0]
        }

- Map is data represented in key-value format

        variable "file-content" {
                type = map
                default = {
                        "key1"="value1"
                        "key2" ="value2"
                }
        }
- We can acces key value as

        resources "local_file" "my-pet" {
                filename= "/roots/pets.txt"
                content= var.file-content["key1"]
        }

- We can also combine type constrainst and if type containst do not match terrform will show error on initialization

        type=list(number)
        type=map(strings)
- Sets are simillaer to list but can not have duplicate elements
- tuple is similler to list but can have element of diffrent data types

        variable kitty {
                type = tuple([strinng, number, bool])
                default=["cat", 7, true]
        }
- Objects represent complex data structures by combining all data types

        variable bella {
                type = object({
                        name= string
                        color=string
                        age=number
                        food=list(string)
                        favorite_pet=bool
                })

                default= {
                        name="bella"
                        color="pink"
                        age=7
                        food=["fish", "turkey"]
                        favorite_pet=true
                }
        }

- Note if variable constarint voileted the the plan will fails

Using input Variables
---------------------

- Documentation : https://developer.hashicorp.com/terraform/language/values/variables
- Interactive Mode : If we defaine the variable in `variables.tf` and don't defined the default values then terraform will propmt for  the values of each variable while doing `terraform apply` 
- Command Line Flags: We can use command like flag `var` like `terraform apply -var "<variable1>=value1" "var2=value2"` for each variable 
- Enviornment Variables: exporting variables as `export TF_VAR_<varName> =value` for each varaible
- Variable definition files: We can store the variables values in files like `terraform.tfvars` as below

        var1=value1
        var2=value2
        .
        .
        .
        varN=valueN
- Name cna be anything but extension should be `.tfvars` or `.tfvars.json`
- filename `terraform.tfvars` or `terraform.tfvars.json` or `*.auto.tfvars` or `*.auto.tfvars.json` are auto loaded any other filename that those shoud be use as `terraform apply -var-file <varFileName>`

Variable definition Prefernce:
-----------------------------

- Enviornmental variables
- terraform.tfvars
- *.auto.tfvars.(alphabetical order)
- -var or -var-file (command line flags)
- 
Resource Attributes
-------------------
- We can link tpw resources by making use of resource attribute refernce
- We can use the output of one resouce to as input of another resource
- We can use attributes in other resources
- The syntax for using attributes is as belwo
  
        resource "local_file" "pet" {
        filename = "/root/pets.txt"
        file_permission = "0700"
        content = "My favorite pet is ${random_pet.my-pet.id}"
        }

        resource "random_pet" "my-pet" {
        prefix = "Mr"
        seperator="."
        length =5
        }

- Documentation: https://developer.hashicorp.com/terraform/language/expressions/references

Resource Dependencies
---------------------

- When resource are li ked by resource attributes then terraform crates the resources in order.
- `Implicit` , when respuce attributes are linked 
- Explicit using `dpends_on` expression in resource block
   
        resource "local_file" "pet" {
        filename = "/root/pets.txt"
        file_permission = "0700"
        content = "My favorite pet is dog"
        depends_on =[random_pet.my-pet]
        }

        resource "random_pet" "my-pet" {
        prefix = "Mr"
        seperator="."
        length =5
        }
- Documentation: https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on

Output Variables
----------------

- To save the values created from logical providers
- https://developer.hashicorp.com/terraform/language/values/outputs
- use below sysntx

        output "instance_ip_addr" {
        value = aws_instance.server.private_ip
        description ="Soethinh"
        }
-  value is mandatory argument and shoudl be an refernce expression
-  This output variables can be put in a file `outputs.tf`
- Use `terraform output` to show the output variables on screen onec `terraform apply` executed. In this way these variables can be passed to ansible or shell scripts.


