Terraform State
---------------

- Documentation: https://developer.hashicorp.com/terraform/language/state
- https://developer.hashicorp.com/terraform/language/state/purpose
- Terraform must store state about your managed infrastructure and configuration. 
- This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.
- This state is stored by default in a local file named `"terraform.tfstate"`, but we recommend storing it in Terraform Cloud to version, encrypt, and securely share it with your team.
- Terraform uses state to determine which changes to make to your infrastructure. Prior to any operation, Terraform does a refresh to update the state with the real infrastructure.
- The primary purpose of Terraform state is to store bindings between objects in a remote system and resource instances declared in your configuration. When Terraform creates a remote object in response to a change of configuration, it will record the identity of that remote object against a particular resource instance, and then potentially update or delete that object in response to future configuration changes.
- 

Purpose of State
----------------
- Tracking Metadata
- Performance
- We dot need to referesn when applying the configuration. We can use `terraform apply --refresh=false` then it will use the `terraform.tfstate` file for the comparasion.
- This file can be stored in central storage S3, Consule or terraform cloud.
  
Terraform State Consideration
-----------------------------
- State is non optional feature
- Statefile contains the sensitive informations
- Satte stored in plan text json files.
- Store in remaote state backed
- No manual edits
- Use `terrafomr state` for that
- Documentation: https://developer.hashicorp.com/terraform/tutorials/state/state-cli