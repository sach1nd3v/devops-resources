Infrastructure Provision in Traditional IT Model
------------------------------------------------
Lets consider a organization wants to rolout a new application.
The business comes with the requirements for the application.
The businesss analyst gathers the need from the business, analyze it and convert it into set of high level technical requirements.
This is then passed to solution architect. The solution architect then designs the architecture to be followed for the deployment of the application. This will typically includes the infra consideration such as type, spec and count of servers such as for the front-end, back-end web servers, load balancers, databases etc.
Follwoing traditional infra model this would have to be deployed in orgnizations on premise environment which means making use of assests of data center.
If additional hardware needed they woudld be auited by procurment team. This team will put new hardware request with vendors.This may take days, to weeks or even months to hardware to be purchaged and delivered to data center.
Once recieved at the data center the field engineer will be in charge of rack and stack of equipment. The sysadmin perfoem initial configuration and netwoekadmin make this systems to be on network.The storage admins assigns the storage to system and backcupadmin configure the backups.
And finally once the systems have been setup as per the standars and policy then they can be ahnded over to application team to deploye applications.

This deployment model which is still commonly used has quite few disadvantages.
The tunover time can range between weeks to months just to get system in ready state to beging the deployment of application.

Traditional IT & Challenges
---------------------------
1. Slow provisioning of Infarstructure on demand
2. Maintenace and deployment is quite Expensive
3. Limited AUtomation  
4. Inconsintency due to human errors
5. Wasted Resources due to underutilization of resources
6. Inconsintency due to human errors
7. No Autoscaling ondemand

Above 1 to 5 problesm can be removed by using Cloud Providers such as AWS, Azure, GCP.But we will still are dependent on scripts to provision ther infrastcture amdn amange the state and consistency.

1. Infra provisioning is quic on cloud
2. No maintennace cost , ony usages cost
3. cloud providers supports API for infra and services which open automation
4. Built-in scaling and elastic functionality reduced resource wastage.

Even through this problem solved by cloud there is possibilty of inconsitency due to human error for large number of infra provisioning.

This can be done by automating using Pythin, Ruby, Shell etc.
This give birth to tools that are known as InfraStructure as Code Tools. Like,
Ansible, Chef, Puppet, Terraform, Plumini, Packre, Vagrant, Saltstack, CloudFormation.

Infrastructure As Code
--------

One way to provision infra as code to make use of cloud api and write code in shell ,python or any programming language to provision manage and configure the infrastructure.
But these codes are not easy to mage . It requres programming logic and developement skill to built and maintain.There are lot of logic to code and not easily readable and reusable.

So There are many tools that makes use of hight level declarative languages to specify infra nd confuguration that are easy to read, maintain and develop and reuse.

Declarative way to configure, deploy and provision infrastructure to remove slowness , human error and inconsitency.
  
We can broadly categorize thes tools in three types as below:

Configuration Management
------------------------
- Designed to Install and Manage Softwares
- Maintains Standard Structure
- Version Control
- Idempotent
- `Ansible, Chef, Puppet, Saltstack`

Serever Templating Tools
------------------------
- Used to create custom images of a VM or container
- Preinstalled Software and Dependencies
- Virtual Machines or Docker Images
- Immutable Infrastructure
- `Docker, Packer, Vagrant`

Provisioning Tools
------------------
- deploy immutable infrastructure resources
- Servers, databases, networks etc.
- Multiple providers , on prem
- Declarative Code
- `Terraform, Plumni, Cloud Formation`

Why Terraform?
--------------

- Terraform is the popular IaC tool which is specifically used to inftastcture provision.
- Free and open source developed by HashiCorp and installed as single binary.
- It can provision infrastcture form any cloud provider include prive cloud as well.(Physival Machines, VMWare, AWS, GCP, Azure etc)
- Provider provide API to use with Terraform to manage everytype of resourec by everytype of infra provider
- Ther are many proiders for many plateforma for many types of resouces.
- Terraform used HCL(HashiCorp Configuration Language) which is declarative language to define infra to be provisi0ned as blocks of code.
-  All infra resource can be defined as blocks of code in a file with .tf extension.
-  The code represent the `desired state` of infrastructure.
-  Terraofmr work in three phases `init, plan and apply`
-  During init phase terraform initilises the project and identifies   providres to be used for target enviornment
-  During Plan phase it draft the plan to get the target state
-  During plan phases it executes the plan to get dessired state.
-  Every object that terraform manages is called reosurce
-  a resourec can be a cloud compute or on prem databse, network etc
-  Terraform manages the lifecycle of resoure form provisioning to configuration to decommissining.
-  Terraform recors the current state fo inftastructure  as it seen in real word and based on that it looks what action to take to update a resoure
-  Terraform ensures that the entire infrasture is in desired state all the time
-  The state is the blueprint of the infrstucture deployed by terraform
-  Terraform can read the attributes of the exising infra resources by configuring datasources.
-  This can later used for configuring other resources within terraform.
-  Terraform can also import other resource form `outside of terraform` to data sources and to be controlled by terraform
-  Terraform cloud provied, collaboration, UI, and central deployment option.