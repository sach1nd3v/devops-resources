Terraform Taint
---------------
- There may be cases where resource creation fails when we run `terraform apply`. In this case terraform marks the resource as `tainted`.
- Tainted resources will be created on subsequest `terraform apply` command.
- We can make an resource as tainted with `terraform taint <resoure_name>` command.
- Then subsequest apply will try to recreate the resource again.
- To undo the taint for a resource use `terraform untaint <resouce_name>`
- Docs: https://developer.hashicorp.com/terraform/cli/commands/taint
- Docs: https://developer.hashicorp.com/terraform/cli/commands/untaint
- Docs: https://spacelift.io/blog/terraform-taint
- Terraform `taint` command is deprecated. We can use -replace option with `apply` command as below

        terraform apply -replace="aws_instance.example[0]"

Debugging
--------
- We can see the errors in plan and apply but we can also look into file logs.
- Terraform has various log levels like `INFO`, `WARNING`, `ERROR`, `DEBUG`,`TRACE`.
- Set log level in env variable as `export TF_LOG_LEVEL=TRACE`
- To record the logs in file use `export TF_LOG_PATH=Some/path.file.log`
- Docs: https://developer.hashicorp.com/terraform/internals/debugging

Terraform Import
----------------
- Importing existing infrastructuet to terraform config
- Some of the resoures may be created outside from terraform either manully from managemnt console or using other tools like ansible etc.
- So to bring those back to in constrol of terraofm we use import as below

        terraform import <resource_type>.<resource_name> <attribute>
- Attribute should be uniue to the resource type
- Note: import only updates the state file. We have to manully write the config 
- Run plan to chek the correctness of config
- Docs: https://developer.hashicorp.com/terraform/cli/import
- Docs: https://developer.hashicorp.com/terraform/language/import
- Docs: https://developer.hashicorp.com/terraform/language/import/generating-configuration