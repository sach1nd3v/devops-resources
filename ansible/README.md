Ansible
=======
- Introduction to Ansible
- Introduction and Configuration
- Ansible Inventory
- Ansible Facts and Variables
- Ansible Playbooks
- Ansible Modules and Plugins
- Ansible Handlers
- Ansible Templates
- Resuing Ansible Content
- URL: https://www.ansible.com/
- URL: https://docs.ansible.com/

Introduction to Ansible
-----------------------
#### Why Ansible
- Provisioning
- Configuration Management
- Continuous Delivery
- Application Deployment
- Security Compliance
- Simple, Powerfull and Agentless
- Ansible has modules avialable for most of the tasks that can be resused
- Playbook Example ...
- ```
  - hosts: localhost
    tasks:
    - user:
        name: johndoe
  ```

#### Script 
- Time
- Coding Skills
- Maintanance
- Eaxmple ... 
-      #!/bin/bash
        # Script to add a user to Linux system
        if [ $(id -u) -eq 0 ]; then
        $username=johndoe
        read -s -p "Enter password : " password
        egrep "^$username" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
        echo "$username exists!"
        exit 1
        else
        useradd -m -p $password $username
        [ $? -eq 0 ] && echo "User has been added 
        to system!" || echo "Failed to add a user!"
        fi
        fi


#### The Curriculum
- Introduction to Ansible
- Setting up Asnible on VirtualBox
- Introduction to YAML
- Inventory Files
- Playbooks
- Variables
- Conditionals
- Loops
- Roles

#### Installtion of Ansible
- Follow the instruction
- URL : https://docs.ansible.com/ansible/latest/installation_guide/index.html

Configuration and Basic Concepts
--------------------------------
#### Ansible Configuration Files
- The default ansible global configuration files are present in `/etc/ansible/ansible.cfg`. See below example...
- Default Structure as ...
  ```
        [defaults]

        [inventory]

        [privilege_escalation]

        [paramiko_connection]

        [colors]

  ```
- Ans eaxmple as..
  
        /etc/ansible/ansible.cfg
        ---
        [defaults]
        inventory = /etc/ansible/hosts
        log_path = /var/log/ansible.log
        library = /usr/share/my_modules/
        roles_path = /etc/ansible/roles
        action_plugins = /usr/share/ansible/plugins/action
        gathering = implicit
        # SSH timeout
        timeout = 10
        forks = 5
        [inventory]
        enable_plugins = host_list, virtualbox, yaml, constructed
        ---

- Ansible supports several sources for configuring its behavior, including an ini file named ansible.cfg, environment variables, command-line options, playbook keywords, and variables
- The `ansible-config` utility allows users to see all the configuration settings available, their defaults, how to set them and where their current value comes from.
- hanges can be made and used in a configuration file which will be searched for in the following order:
-   
        1. ANSIBLE_CONFIG (environment variable if set)

        2. ansible.cfg (in the current directory)

        3. ~/.ansible.cfg (in the home directory)

        4. /etc/ansible/ansible.cfg

- Ansible will process the above list and use the first file found, all others are ignored.
- URL: https://docs.ansible.com/ansible/latest/installation_guide/intro_configuration.html

###### View Configuration
- `ansible-config list` # List all configurations
- `ansible-config view` # Shows the current config file
- `ansible-config dump` # Shows the current settings

Introduction to YAML
--------------------

#### What is YAML
- All Ansible playbooks are written in YAML
- YAML file store configuration data
- Key/value Pair
- There should be a space after colon, before value
  ```
  Fruit: Apple
  Vegetable: Carrot
  Liquid: Water
  Meat: Chicken
   
  ```
- Array/List, dash`-`, represent that element is part of an array/list
  ```
   Fruits: 
   - Orange
   - Apple
   - Banana
   Vegetables:
   - Carrot
   - Cau
  ```
- Dictionary/Map, is set of key/value pairs grouped together under a item
- There should be equal number of spaces before each properties of an item so that they are all aligned together
 ```
 Banana:
   Calories: 105
   Fat: 0.4 g
   Carbs: 27 g
Grapes:
  Calories: 62
   Fat: 0.3 g
   Carbs: 16 g
 ```

 - above three can be combined to make complex data formate
 - Eaxmple key-value,dictionaty/list
  ```
  Fruits:
  - Banana:
        Calories: 105
        Fat: 0.4 g
        Carbs: 27 g
  - Grapes:
        Calories: 62
        Fat: 0.3 g
        Carbs: 16 g
  ```
 - To represnte the diffrent properties of a item use dictionary and use list to repseret same type of items
 - Example list of dictionaries
  ```
        - name: John Doe
          age: 30
          city: New York
        - name: Jane Smith
          age: 25
          city: Los Angeles
        - name: Bob Johnson
          age: 35
          city: Chicago
  ```
 - Dictionaries are unordered while list is ordered
 - Use # for comments
 - URL: https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started
 - https://www.redhat.com/sysadmin/understanding-yaml-ansible
 - https://www.tutorialspoint.com/yaml/index.htm


Ansible Inventory
-----------------
- Ansible Can work with many systems at the same time using `SSH` on Linux and `Powershell Remoting` on windows.
- This amkes ansible `agentless`
- Now the information about target systems is stored ina file called `inventory`
- Deafult inventory file located at `/etc/ansible/hosts`
- Inventory file cabn be either `INI` or `YAML` formate
- in INI formate theere are servers listed one after another also grouped together as below...
```
server1.company.com
server2.company.com
[mail]
server3.company.com
server4.company.com  
[db]
server5.company.com
server6.company.com
[web]
server7.company.com
server8.company.co
```
- We can add alias to the servesr and refere to servers with `ansible_host` parameters.
- `ansible_host` is inventory parameter used to spacify FQDN or IP of server and there are other inventory parameters as welll as below..
```
Inventory Parameters:
• ansible_connection – ssh/winrm/localhost
• ansible_port – 22/5986
• ansible_user – root/administrator
• ansible_ssh_pass - Password

```
```
web  ansible_host=server1.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=P@#
db   ansible_host=server3.company.com ansible_connection=winrm ansible_user=admin
mail ansible_host=server2.company.com ansible_connection=ssh ansible_user=root
web2 ansible_host=server4.company.com ansible_connection=winrm

localhost ansible_connection=localhost

```
- We can use `ansible_connection=localhost` to work on same machine as ansible controller
- It is not best practice to store password in plain text. In production setup the SSH keybased authentication or use `Vault` provided by the ansible.
#### Inventory Formates
- For small startups INIt formate will suffice
- For large organizations with diffrent teams and complexity YAMl formate is sutable for structuring the inventory
- YAML formate is more flexible and structured
- Suitable fo large complex orgrnxation with various departmenets
- The INI format is the simplest and most straightforward.
```
[webservers]
web1.example.com
Web2.example.com
[dbservers]
db1.example.com
db2.example.com
```
- The YAML format is more structured and flexible than the INI format.
```
all:
 children:
  webservers:
   hosts:
    web1.example.com:
    web2.example.com:
  dbservers:
   hosts:
    db1.example.com:
    db2.example.com
```
- URLS: https://docs.ansible.com/ansible/latest/inventory_guide/
- URLS: https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html
#### Grouping groups: parent/child group relationships
- You can create parent/child relationships among groups. Parent groups are also known as nested groups or groups of groups. For example, if all your production hosts are already in groups such as atlanta_prod and denver_prod, you can create a production group that includes those smaller groups. This approach reduces maintenance because you can add or remove hosts from the parent group by editing the child groups.
- in INI format, use the `:children` suffix, in YAML format, use the `children:` entry
```
ungrouped:
  hosts:
    mail.example.com:
webservers:
  hosts:
    foo.example.com:
    bar.example.com:
dbservers:
  hosts:
    one.example.com:
    two.example.com:
    three.example.com:
east:
  hosts:
    foo.example.com:
    one.example.com:
    two.example.com:
west:
  hosts:
    bar.example.com:
    three.example.com:
prod:
  children:
    east:
test:
  children:
    west:
```
```
[webservers:children]
webservers_us
Webservers_eu
[webservers_us]
server1_us.com ansible_host=192.168.8.101
server2_us.com ansible_host=192.168.8.102
[webservers_eu]
server1_eu.com ansible_host=10.12.0.101
server2_eu.com ansible_host=10.12.0.10
```
Ansible Variables
----------------
#### Defining Variables
- Stores the information that varies with each hosts...liek hostname, user name, passowrds, what to install etc
- Suppose our inventry is liek thsi..
```
Web1 ansible_host=server1.company.com ansible_connection=ssh ansible_ssh_pass=P@ssW
db   ansible_host=server2.company.com ansible_connection=winrm ansible_ssh_pass=P@s
Web2 ansible_host=server3.company.com ansible_connection=ssh ansible_ssh_pass=P@ssW

```
- As of now wehave used varibles(ansible inventory parametrs)
- We can also defined the variables inside the playbooks as well using `vars` directive and variables as key/value paire
```
-
name: Add DNS server to resolv.conf
hosts: localhost
vars:
 dns_server: 192.168.1.19
tasks:
- lineinfile:
   path: /etc/resolv.conf
   line: 'nameserver 10.1.250.10'
```
- We can also defined the variables in a seperate varaibles files
```
variable1: value1
variable2: value2
```
#### Using Variables
- We can refernce the variables using jinja2 templating as belwo...
```
name: Add DNS server to resolv.conf
hosts: localhost
vars:
 dns_server: 192.168.1.19
tasks:
- lineinfile:
   path: /etc/resolv.conf
   line: 'nameserver {{ dns_server }}'
```
- Another examples as below...
```
--- variables.yml
#Sample variable File – web.yml
http_port: 8081
snmp_port: 161-162 
inter_ip_range: 192.0.2.0
---
pplaybook.yml
-
name: Set Firewall Configurations
hosts: web
tasks:
- firewalld: 
    service: https 
    permanent: true 
state: enabled 
- firewalld: 
	port: '{{ http_port }}'/tcp 
	permanent: true 
	state: disabled 
- firewalld: 
	port: '{{ snmp_port }}'/udp
	permanent: true 
	state: disabled 
- firewalld: 
	source: '{{inter_ip_range}}'/24
	Zone: internal
	state: enabled
```
#### Variables Types
- `String` variables in Ansible are sequences of characters. They can be defined in a playbook, inventory, or passed as command line arguments.
```
username: "admin
```
- `Number` variables in Ansible can hold integer or floating-point values. They can be used in mathematical operations.
```
max_connections: 100
```
- `Boolean` variables in Ansible can hold either true or false.They are often used in conditional statements.
```
debug_mode: true
```
- `List Variables` s in Ansible can hold an ordered collection of values.The values can be of any type. 
```
packages:
- nginx
- postgresql
- git
```
```
- 	name: Install Packages Playbook
	hosts: your_target_hosts
	vars:
		packages:
		- nginx
		- postgresql
		- git
	tasks:
		- name: Display all packages
		debug:
			var: packages
		- name: Display the first package
			debug:
				msg: "The first package is {{ packages[0] }}"
		- name: Install packages using package manager (apt/yum)
		become: true # To escalate privileges for package installation, if required
		# Replace with appropriate package management tasks based on the target system (apt/yum)
		# For this example, we'll just use the debug module to simulate the installation
		debug:
			msg: "Installing package {{ item }}"
		loop: "{{ packages }}"
```
- `Dictionary` variables in Ansible can hold a collection of key-value pairs.The keys and values can be of any type. 
```
- 	name: Access Dictionary Variable Playbook
	hosts: web_servers
	vars:
		user:
			name: "admin"
			password: "secret"
	tasks:
	- name: Display the entire user dictionary variable
	  debug:
		var: user
	- name: Access specific values in the dictionary
	  debug:
		msg: "Username: {{ user.name }}, Password: {{ user.password }}"
	```

#### Registering Variables and Vaeriables Precedence
- If a variable defined in inventory associated with host, or in host group or in play books or in command lien then the following is order of precdenced from top to bottom in increasing precdence..

```
    #/etc/ansible/hosts

	web1 ansible_host=172.20.1.100
	web2 ansible_host=172.20.1.101 dns_server=10.5.5.4
	web3 ansible_host=172.20.1.102
	[web_servers]
	web1
	Web2
	web3
	[web_servers:vars]
	dns_server=10.5.5.3

	# playbook.yml
	---
	- name: Configure DNS Server
	  hosts: all
	  tasks:
	  - nsupdate: 
	     server: ‘{{ dns_server }}’
	# CMD args
	ansible-playbook playbook.yml –-extra-vars “dns_server dns_server==10.5.5.6” 10.5.5.6
    - URL: https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html

	```
##### Registering task results in variable
- We can user `register` directive to capture the output of an task in playbooks as below.. and debug to putput on stdout
```
	---
	- name: Check /etc/hosts file
	  hosts: all
	  tasks:
		- shell: cat /etc/host
		  register: result
		- debug:
		    var: result
```

- Note the scope of the regsiter variable is on host and is avialble to any task/play runnig on that host

#### Variable Scoping
- A scope defines the accessbilty, visibility of a variable .
- It depends how and where it is defined.
- A variables defined as `host variable` as `host` and is accessible within the play that is run forthe host
```
web1 ansible_host=172.20.1.100
web2 ansible_host=172.20.1.101 dns_server=10.5.5.4
web3 ansible_host=172.20.1.102

# Playbook.yml

---
- name: Print dns server
  hosts: all
  tasks:
  - debug: 
     msg: ‘{{ dns_server }

# Output
PLAY [Check /etc/hosts file] 
***************************************************
TASK [debug] ***************************************
ok: [web1] => {
"dns_server": "VARIABLE IS NOT DEFINED!"
}
ok: [web2] => {
"dns_server": "10.5.5.4"
}
ok: [web3] => {
"dns_server": "VARIABLE IS NOT DEFINED!"
}

```
- A variable defined as play level has `play` scope
```
---
- name: Play1
  hosts: web1
  vars:
   ntp_server: 10.1.1.1
  tasks:
  - debug:
     var: ntp_server
- name: Play2
  hosts: web1
  tasks:
  - debug:
     var: ntp_server
```
- A variables passed as `extra-vars` has `global scope`
```
 ansible-playbook playbook.yml –-extra-vars “ntp_server=10.1.1.1”
# Plabook.yml

---
- name: Play1
  hosts: web1
  vars:
    ntp_server: 10.1.1.1
  tasks:
  - debug:
      var: ntp_server
- name: Play2
  hosts: web1
  tasks:
  - debug:
      var: ntp_server

# Output
PLAY [Play1] ********************************************************
TASK [debug] ********************************************************
ok: [web1] => {
"ntp_server": "10.1.1.1"
}
PLAY [Play2] *******************************************
TASK [debug] ********************************************************
ok: [web1] => {
"ntp_server": "10.1.1.1"

```
#### Magic variables
- You can access information about Ansible operations, including the python version being used, the hosts and groups in inventory, and the directories for playbooks and roles, using “magic” variables. 
- Like connection variables, magic variables are Special Variables. Magic variable names are reserved - do not set variables with these names. The variable environment is also reserved.
- The most commonly used magic variables are hostvars, groups, group_names, and inventory_hostname. With hostvars, you can access variables defined for any host in the play, at any point in a playbook.
```
#/etc/ansible/hosts
web1 ansible_host=172.20.1.100
web2 ansible_host=172.20.1.101 dns_server=10.5.5.4
web3 ansible_host=172.20.1.10

#Playbook
---
- name: Print dns server
  hosts: all
  tasks:
  - debug: 
      msg: ‘{{ dns_server }}

# Output
PLAY [Check /etc/hosts file] 
***************************************************
TASK [debug] ***************************************
ok: [web1] => {
"dns_server": "VARIABLE IS NOT DEFINED!"
}
ok: [web2] => {
"dns_server": "10.5.5.4"
}
ok: [web3] =>{
"dns_server": "VARIABLE IS NOT DEFINED!"
}

```
- Note the variable defined at host level not accessible for other hosts but we can access it using magic variables `hostvars` as below..
```
---
- name: Print dns server
  hosts: all
  tasks:
  - debug: 
      msg: ‘{{ hostvars['web2']. dns_server }}'

# Output
PLAY [Check /etc/hosts file] 
***************************************************
TASK [debug] ***************************************
ok: [web1] => {
"dns_server": "10.5.5.4"
}
ok: [web2] => {
"dns_server": "10.5.5.4"
}
ok: [web3] => {
"dns_server": "10.5.5.4"
}
```
- If facts are gathered then we can use below syntax go gather more information about other host system...
```
---
- name: Print dns server
  hosts: all
  tasks:
  - debug: 
      msg: ‘{{ hostvars['web2']. dns_server }}’
      msg: ‘{{ hostvars['web2'].ansible_host }}’
      msg: ‘{{ hostvars['web2'].ansible_facts.architecture }}’
      msg: ‘{{ hostvars['web2'].ansible_facts.devices }}’
      msg: ‘{{ hostvars['web2'].ansible_facts.mounts }}’
      msg: ‘{{ hostvars['web2'].ansible_facts.processor }}’
      msg: ‘{{ hostvars['web2']['ansible_facts']['processor'] }}'
```
- Other magic variables rae `groups`, `group_names` and `inventory_hostname`
```
#/etc/ansible/hosts
web1 ansible_host=172.20.1.100
web2 ansible_host=172.20.1.101
web3 ansible_host=172.20.1.102
[web_servers]
web1
Web2
web3
[americas]
web1
web2
[asia]
web3

# groups var in playbook as 
msg: ‘{{ groups[‘americas’] }}’
# Output
web1
web

# graoup_names used as 
msg: ‘{{ group_names }}’
# Output as 
web_servers
americas

# inventory_hostname var use
msg: ‘{{ inventory_hostname }}’


```

# Ansible Facts
- When playbooks runs it firts collect information about the system..like memeory, os , ip, MAC, etc
- This information are knows as facts in ansible
- Ansible gathers all the facts using`setup` module
- `setup` module gather the facts about hosts  automatically when you run the playbook even if you did not use in playbook
- All facts gathered by ansible is stored in variable called `ansible_facts`.
```
---
- name: Print hello message
hosts: all
tasks:
- debug:
   msg: Hello from Ansible

# Ouputs conatains default task setup module
PLAY [Print hello message] **********************************************************
TASK [Gathering Facts] **************************************************************
ok: [web2]
ok: [web1]
TASK [debug] *********************************************************************
ok: [web1] => {
"msg": "Hello from Ansible!"
}
ok: [web2] => {
"msg": "Hello from Ansible!"
}
msg: Hello from Ansible

```
- to desable gapthering facts use `ansibel_facts: no` at play level or update ansible.cfg
```
- name: Print hello message
hosts: all
ansibel_facts: no
tasks:
 - debug:
    var: ansible_facts

# Output
PLAY [Print hello message] **********************************************************
TASK [debug] ************************************************************************
ok: [web1] => { "ansible_facts": {} }
ok: [web2] => { "ansible_facts": {} 

# In asnible.cfg

#/etc/ansible/ansible.cfg
# plays will gather facts by default, which contain information about
# smart - gather by default, but don't regather if already gathered
# implicit - gather by default, turn off with gather_facts: False
# explicit - do not gather by default, must say gather_facts: True
gathering = implici
```

Ansible Playbooks
-----------------
- Ansible playbook is the ansible orschestration language
- It is the playbook where we defined what we want ansible to do
- A playbook is single YAMl file
- Playbooks defined a set of activities to be done on the hosts
-  Activities or tasks are the actions that are performd on the gost
-  Like xcute a command, run a script or intall a package
-  shutdon/restart
```

name: Play 1
hosts: localhost
tasks:
- name: Execute command ‘date’
command: date
- name: Execute script on server
script: test_script.sh
- name: Install httpd service
yum: 
name: httpd
state: present
- name: Start web server
service:
name: httpd
state: started
 # Other one

 -
-
name: Play 2
hosts: localhost
tasks:
name: Play 1
hosts: localhost
tasks:
- name: Execute command ‘date’
command: date
- name: Execute script on server
script: test_script.sh
- name: Install web service
yum: 
name: httpd
state: present
- name: Start web server
service:
name: httpd
state: started
```
- Playbook is basically list of plays(which is dictionary)
- It has properties like name, hosts and tasks
- Task is the list and oredr matter
- hosts, defined the host on which the staks of that play will run
- it is taken from the inventory file
- The diffrent actions/tasks are called module
```
-
name: Play 1
hosts: localhost
tasks: - name: Execute command ‘date’
command: date
- name: Execute script on server
script: test_script.sh
- name: Install httpd service
yum: 
name: httpd
state: present
- name: Start web server
service:
name: httpd
state: started

####

-
name: Play 1
hosts: localhost
tasks:
- name: Execute command ‘date’
command: date
- name: Execute script on server
script: test_script.sh
- name: Install httpd service
yum: 
name: httpd
state: present
- name: Start web server
service:
name: httpd
state: started
```
- To execute a playboos we will use
```
Execute Ansible Playbook
ansible-playbook playbook.yml

```

##### Veryfy the playbooks
- Check mdoe or dry run
- It will show the previw of the run
- use --check option to see the preview
- Diff mode will show the before and after changes
- use --diff option
- Syntax check, use --syntax-check option

###### Asnible Lint
- Use command `ansible-lint playbook.yml`

##### Conditionals in Playbook
- Conditional `when`
```
---
- name: Install NGINX
  hosts:
  tasks:
  - name: Install NGINX on Debian
    apt:
      name: nginx
      state: present
    when: ansible_os_family == “Debian” 
  
  - name: Install Nginx on RedHat
    yum:
      name: nginx
      state: present
    when: ansible_os_family == “RedHat” 
```
##### Conditional in Loops

```
---
- name: Install Softwares
  hosts: all
  vars:
    packages:
    - name: nginx
      required: True
    - name: mysql
      required : True
    - name: apache
      required : False
  tasks:
  - name: Install {{ item.name }}on Debian
    apt:
      name: '{{ item.name }}'
      state: present
    when: item.required == True
  
    loop: "{{ packages }}"
```

#### Asnible Loops
- Loops used to repeat same task with diffenrt parameters
```
-
name: Create users
hosts: localhost
tasks:
  - user: name='{{ item }}' 
    state=present
    loop:
    - joe
    - george
    - ravi
    - mani
    - kiran
    - jazlan
    - emaan
    - mazin
    - izaan
    - mike
    - menaal
    - shoeb
    - rani

## Above will expand as
-
name: Create users
hosts: localhost
tasks:
  - var: item=
    user: name= “{{ item }}” state=present
  - var: item=
    user: name= “{{ item }}” state=present
  - var: item=
    user: name= “{{ item }}” state=present
  - var: item=
    user: name= “{{ item }}” state=present
  - var: item=
    user: name= “{{ item }}” state=present
  - var: item=
    user: name= “{{ item }}” state=present
  - var: item=
    user: name= “{{ item }}” state=present
  - var: item=
    user: name= “{{ item }}” state=present
  - var: item=
    user: name= “{{ item }}” state=presen
```

#### Ansible Modules
- modules provides the task to be excuted by ansible
- free_from input, means no prametrizzed iput using`=` in module

##### Ansible Plugins
- Plugins that provies addiootunal functionlity to ansible like uing dynmic inventory
- Like inventory, modules, callbacks, action plugin, kookup plugins, connection plugins, dynamic inventory plugins
- Moudle and plugin index

#### Ansible Handlers
- Handlers are special task triggerd by event/notification
- Defined in playbook and execuedt when notified by the task
```
- name: Deploy Application
  hosts: application_servers
  tasks:
  - name: Copy Application Code
    copy: 
      src: app_code/
      dest: /opt/application/
    notify: Restart Application Service

  handlers:
  - name: Restart Application Service
    service:
      name: application_service
      state: restarted
```

#### Ansible Roles
- roles are pice of ansibel code that can be used for various purpouse
- We can resue various codes without rewriting this using roles..
```
- name: Install and Configure MySQL 
  hosts: db-server
  tasks:
  - name: Install Pre-Requisites
    yum: name=pre-req-packages state=present
  - name: Install MySQL Packages
    yum: name=mysql state=present
  - name: Start MySQL Service
    service: name=mysql state=started
  - name: Configure Database
    mysql_db: name=db1 state=presen
```
- Aboce can be splits in roles as below
```
name: Install and Configure MySQL 
hosts: db-server1 .... db-serverN
roles:
- mysql

## task of mysql role
tasks:
- name: Install Pre-Requisites
  yum: name=pre-req-packages state=present
- name: Install MySQL Packages
  yum: name=mysql state=present
- name: Start MySQL Service
  service: name=mysql state=started
- name: Configure Database
  mysql_db: name=db1 state=present

```
- A role consists of `tasks`, `vars`, `defaults`, `templates`, `handlers`, and `meta`. Directory
- We can resue a role as mentione above
- Generally we creates the `roles` directory where out `playbook.yml` is present
- Or we can specify the roles directory in `ansible.cfg`
- To list roles use `ansible-galexy list`
- To install a role use `ansible-galexy install <roleName -p <dir>`