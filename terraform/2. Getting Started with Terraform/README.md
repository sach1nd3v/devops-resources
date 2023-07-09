Installing Terraform
--------------------
- Steps: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- https://developer.hashicorp.com/terraform/downloads 
- Terraform comes as single binary that can be put at `/usr/bin, /usr/local/bin`
- Use `terraform version` to veryfy installtion
- It is supported on mazor linux distributions, macOS, Windows and Unix base distributions.
- Reosurces can be defined in HCl in file with `.tf` extention with any editor.
- A `resourec` is a object that terraform manages, it can be a file on localhost ,VM on cloud, S3, IAM, roles Policy, app engine, Databases.. Azure Active Directory etc.
- Some of simple resources are Local files and random bit resources.

The Terraform language is `declarative`, describing an intended goal rather than the steps to reach that goal. The ordering of blocks and the files they are organized into are generally not significant; Terraform only considers `implicit` and `explicit` relationships between resources when determining an order of operations.

Example 

HCL Basics
----------

- HCL language refernce: https://developer.hashicorp.com/terraform/language
- Look for resources here: https://registry.terraform.io/providers/hashicorp/aws/latest
- The main purpose of the Terraform language is declaring resources, which represent infrastructure objects.
-  All other language features exist only to make the definition of resources more flexible and convenient.
-  A Terraform configuration is a complete document in the Terraform language that tells Terraform how to manage a given collection of infrastructure. A configuration can consist of multiple files and directories.
-  HCL file consists of `blocks and arguments`
  
        <block> <parameters> {
                key` = valu1
                key2 = value2
        }

-  A block is defined in curley braces and contains set of  arguments in key value format representing the congfiguration data.
-  Ablock represet the infra platfoem and setof resource that we want to provison.
-  Blocks are containers for other content and usually represent the configuration of some kind of object, like a resource. Blocks have a block type, can have zero or more labels, and have a body that contains any number of arguments and nested blocks. Most of Terraform's features are controlled by top-level blocks in a configuration file.
-  Arguments assign a value to a name. They appear within blocks.
-  Expressions represent a value, either literally or by referencing and combining other values. They appear as values for arguments, or within other expressions.


- For examples::

        resource "aws_vpc" "main" {
        cidr_block = var.base_cidr_block
        }

        <BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
        # Block body
        <IDENTIFIER> = <EXPRESSION> # Argument
        }

- Note here "resource" is bloc type
- "aws_vpc", aws is the provider name and vpc is the resource provided by provider
- "main" is the logical name given to this particuar resource.


Terraform workflow
-----------------
1. Write the configuration file
2. Run the `terraform init` command. This command Checks the configuration file and initialized the working directory containing the `.tf` file. It download the plugin for the particular type of provider and resources.
3. Review the execution plan by runnig `terraform plan`  command. It will shoow in details what terraform will do to create thesource. This command shows the output like a diff command. What will be created and what will be destroyed.
4. Some default and optional arguments are also showed.
5. Now once ready apply the changes using `terraform apply` command
6. Run `terraform show` to see the resource created . This command inspect the state file and show the resources.
7. Look for providers documentation here: https://registry.terraform.io/browse/providers


Updating and destroying the resources:
-------------------------------------
- Any changes to configuration file will make the older infratructure to destroy and new to be created with changes.
- This is called immutable infrstructure.
- For example created a file using `local` provider then chnage the `file_permission` then apply the plan. It will delete older file then crated new file with given apermissions.
- more on `terraform destroy` command here https://developer.hashicorp.com/terraform/cli/commands/destroy