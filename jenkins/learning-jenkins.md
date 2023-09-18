Jenkins
=======

Introduction
------------
##### Getting started with Jenkins


- In software development, and system administration, `automation` saves time, and helps you work more efficiently. 
- Jenkins is a framework that you can use to manage all types of automation, including `software builds`, `application testing`, deployments and much more. 
-  We'll also explore advanced configurations that use `source code repositories, parameters and schedules` and  creating `pipelines` from code.

##### Why choose Jenkins?
- Ease of use : `intuitive web Interface, Easy to navigate and Documentation and example included`
- Free and open-source.
- Extensibility: `plugin archtecture, new feature can be developed`

##### Key Terminology:
- `Project` or `Job`: A user configured description of work/task that Jenkins will perform and manage. Job and Project are used interchangeably.
- `Build`: A single run of job(project)
- `Build Step`: A task inside a job
- `Build Trigger` : Criteria for starting a build (manual or automatic)
- `Plugin`: A software package that extends the Jenkins core functionality

Install Jenkins
---------------
#### 
- Jenkins can be installed on any OS(Linux, MacOS and Windows) with supported java.
- Jenkins is a web based application.
- Jenkins can be installed as container also.
- Follow the documentaion : https://www.jenkins.io/doc/book/installing/

##### Jenkins User Interface
##### Plugin management
- Install/ Uninstall Plugins 
- Manage Jenkins> Plugins

Jobs In Jenkins
--------------
- Jenkins provides varioys type of project(job) for various need and requirements. The `freestyle` job is the simplest one, combined with SCM, build tools, can be used to run various type of taks, apart from the project buid.
- Generally a job has following configuration sections which depends on the plugin installed. Each section can be customized using respective plugins.
- `General` : Job description , parameters,can be specified
- `SCM` : Source code repositories related setting  like repos url, branch , etc can be specified here
- , `Build Triggers` : Specifies how a build will be triggred
- `Build Environment`: Settings related to workspace and other stuffs. `Build Steps` : Actual tasks that will run for the projcet like ,runnig a command or maven build.
- `Post-build Actions` : Action to be performed after the build depenning on the status of build like sending mail, updating status on github, publishing reports, archiving the artifact etc.
- Section can have various things dependening on the `plugins` installed.
- 
##### Types of jobs
- `Freestyle jobs` : Freely contolr and cuntomize the task that Jenkins manage and automate anythings
- `Pipeline Jobs` : Orchestrates long-running activities that can span multiple build agents. Suitable for building pipelines (formerly known as workflows) and/or organizing complex activities that do not easily fit in free-style job type.
- `MultiBranch Pipeline` : Creates a set of pipleine projects accroding to detected SCM branches in SCM
- `Folder` : Craetes the containers for nested items/jobs
- `Organization Folder` : Creates  a set of multi branch subfolder by scanning for repositories
- `Multi Configuration Project` : Suitable for the projects that needs a large number of diffrent configurations like testing of diffrent environment or plateform specif-builds.
- Note : Many Plugins can add difrent type of Jobs based on requirememts

- `Browsw Job Workspace` :
- `Manage Artifacts` : If the project build producing the any artifacs then we can choose weather to archive or discrad. We can use `archive the artifact` step in `POSt build action` to archive the artifact.
- `Scheduling a JOB` : We can use `Build Peridiocally` in `Build Trigger` section and give `cron` like syntax to run the job periodically.

##### Parameters and Environment Variables
- We can pass `parametsr` to the job. Jenkins provides variosu types of parametrs like, string, choice, bollean , credential parametrs etc.
- We can reference this parameters in shell or batch script in thier respective synstax, example for shell we can use
```
echo $STAGING_ENV
```
- Enviornment varaibles are automatically created when a job runs and can be refernced in the spteps.
- Some of the commonlly used are BUILD_NUMBER and BUILD_ID
- Refer: 
Using Global Build Tool:
------------------------
- In Global Tool Configurations we can configure the various tools (git, maven, java, gradle etc) and their configurations to be avialble during the project build.
- Go to `Manage Jenkins` > `Tools`

Organizing Jobs in View and Folders:
-----------------------------------
- Create a view
- Create a folder
- Delete view and Folder
- 

Manage Jenkins:
--------------
#### System Configuration
- `System Configurations` : User Authentication, LDAP, Configure Jenkins ULR, Connection to Github, Executers mail servsr etc.
- `Tools` : Configure tools to be available to build
- `Plugins` : Manage Plugins
- ` Node and Clouds` : Add/Remove Monnitpr various nodes, docker, cloud agnets

#### Security
- `Security` : Authentication, API access, SSSh access etc
- `Credentials` : Adds credentials to be configured in Jobs
- ` Credential Provider` : 
- ` Users` : Adds users to jenkins database

.....