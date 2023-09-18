Jenkins
=======

Introduction
------------
- The Jenkins continuous integration platform is one of the most capable and widely used automation frameworks in the world.
- In this course we'll look at advanced ways to use Jenkins.
-  We'll start by discussing why Jenkins is an excellent tool for enabling a DevOps approach to software development. 
- Then we'll see how Jenkins allows engineers and developers to create pipelines using configuration as code stored in GitHub repositories. 
- We'll go even further as we explore distributed builds, managing artifacts, and the steps needed to keep Jenkins secure.
- URL: https://www.jenkins.io/doc/

Prequisites
-----------
- Install Plugins
- Configure  Global Tools
- Create and run freestyle jobs
- Use parameters with Jobs

Jenkins and DevOps
------------------
- The DevOps Life Cycle consists of `eight stages` in the `planning, development, and operation` of a system, or software application. 
- The DevOps Life Cycle is presented as an infinity symbol because the cycle is continuous. Each step is repeated in order until the system or application is decommissioned. 
- The loop is divided into two groups with the first group representing the `development stages` of the cycle, and the second group representing the `operational stages`.
- In the development group we start with the stage labeled `plan` and then move on to `code`, `build` and `test`. 
- In the operations group we continue the cycle with `release`, `deploy`, `operate` and `monitor`.
-  Jenkins is the perfect tool for `automating processes`, tied to the `build, test, release and deploy` stages.
- When tools like Jenkins are used to automate the `build and test` stages, the process is known as `continuous integration`. 
- Using automation in the `release and deploy` stages is called `continuous delivery`. 
- And if the process is `completely automated`, it can be referred to as `continuous deployment`. 
- Continuous integration often abbreviated as CI is tied to the build and test phases of the DevOps Life Cycle. The main goal of continuous integration is to find and resolve problems early in the development cycle. These steps also produce an artifact that can be deployed. 
- Jenkins automates building and testing by running commands that create the software artifact and run it through a series of tests. This artifact could be a container image, Java archive, a windows executable, or any other sort of software package. Once the tests have passed, the artifact can be moved on to the next stage in the process. 
- Continuous delivery and deployment are often referred to as CD. CD is tied to the release and deploy stages of the DevOps Life Cycle. These stages take an artifact and make it available for use, or actually put it to work. 
- The release stage is where the delivery happens. Jenkins may upload a container image to a repository, or make a jar file available for downloading. Ultimately, delivering the artifact means that a version of the application is available and ready to be used. The next step is to deploy. 
- In some cases the deployment is manual. For a continuous deployment, all steps are automated and completed with no, or very little human interaction. 
- In our case, we would give Jenkins the instructions needed to deploy automatically. Now that we've discussed how Jenkins fits into the DevOps Life Cycle, and how Jenkins can be used for CI/CD, let's set up a Jenkins server that we can use to explore the topics in this course.

Jenkins Installation
--------------------
- URL: https://www.jenkins.io/doc/book/installing/

Jenkins Pipeline
----------------
- Jenkins supports `scripted` and `declarative` pipeline.
- Scripted pipeline starts with `node` block and uses Groovy based DSL.
- Declarative piplein starts with `pipeline` block and evolution of scripted piplein and modesl the CI/CD with more readable syntax.

#####First Pipeline Example
- Go to `New Item` > Give the name > Then Select `Pipeline`and OK.
- Go to `Pipeline` tab > Select definition `Pipeline script` > and in Script select `Hello World` from the `try sample pipeline` dropdown.
- Script body will be as below...

        pipeline {
            agent any

            stages {
                stage('Hello') {
                    steps {
                        echo 'Hello World'
                    }
                }
            }
        }

#####Declarative Pipeline Syantx
- Declarative pipeline must start with `pipeline` block.
- It is required to have a `agent` section, `stages`section and at leat one `stage` section and at least one `steps` section.
- Above pipeline example is the minimal pipeline with required sections.
  
######Agent
- `agents` section specifies the machine where the commands of pipline will run. We can use several parameter to specify the an agent.
- Some of the parameters as as `any`, `label`, `docker` and `none`.
- `any` : We are letting jenkins to run the pipeline on first avialebl executer. Generaly used when using controller as executer as well.
- `agent { label 'linux' }` : runs on the agent which have specified label.
- `agent { docker { image 'maven' } }` run the pipeline inside a docker container using specified image.When need fresh environment for each build.
- `agent none` : defer agent selection to stages.Allows to use diffrent agent for diffrent stages in pipeline.

######Stages
- In the stages section of a pipeline, we identify specific parts of the process being automated. 
- If we were developing a CICD pipeline, for example, we could use stages named `build, test, and deploy` to represent the actions needed for an application deployment. Each stage must contain at least one steps section. 
- In the steps section, we list the commands that actually do something. This is where we run programs, scripts and commands that interact with the compute platform that the pipeline is running. 
- We can have multiple commands in each step. Let's create a new pipeline that has multiple stages and steps.
  

        pipeline {
            agent any
            stages {
                stage('Requirements') {
                    steps {
                        echo 'Getting Requirements....'
                    }
                }
                stage('Build') {
                    steps {
                        echo 'Building....'
                    }
                }
                stage('Test') {
                    steps {
                        echo 'Testing..1'
                        echo 'Testing..2'
                        echo 'Testing..3'
                    }
                }
                stage('Report') {
                    steps {
                        echo 'Reporting....'
                    }
                }
            }
        }
- Test above pipelin by pasting in the script body in the piplein script in Jenkins job.

######Piepeline Steps
- Stpes are the smallest unit and buildg blocks that runs to do actual work.
- Various plugins provide various steps for diffrent types of work.
- `echo` : Just print the message on console.
- `git` : Checkout repo from git repository
- `sh` : Run a script of local command
- `archiveArtifact` : Archive artifacts created by the Job
- Basic Steps reference: https://www.jenkins.io/doc/pipeline/steps/workflow-basic-steps/
- Additional Piplein stpes for tools and plugins: https://www.jenkins.io/doc/pipeline/steps/

#####Pipeline Snippet Generator
- Jenkins provides a pipeline syntax generator that we can use to crate Snippets of code that we can copy into a pipeline.
- You can find the syntax generator by clicking the Pipeline synax link at the bottom of the pipeline editor window or by opening [YOUR_JENKINS_SERVER_URL]/pipeline-syntax.
  
        pipeline {
            agent any
            stages {
                stage('Report') {
                    steps {
                        sh 'echo "this is a report" > report.txt'
                    }
                }
            }
        }

- Archive Step Snippets

        pipeline {
            agent any

            stages {
                stage('Report') {
                    steps {
                        sh 'echo "this is a report" > report.txt'
                        archiveArtifacts allowEmptyArchive: true,
                            artifacts: '*.txt',
                            fingerprint: true,
                            followSymlinks: false,
                            onlyIfSuccessful: true
                    }
                }
            }
        }
Use the snippet generator to create a step for the following pipeline that archives all files ending with .txt:

#####Variables in Pipeline
- There are three types of variabes as `Environment, parameters and build`.


######Environment Variables
- The Usual practice is to use all CAPS for enviornment varaibel.
- Can be scoped globally for entire pipeline or localy for a single stage.
---Globally Scoped

        pipeline {
            agent any
            environment {
                MAX_SIZE = 10
                MIN_SIZE = 1
            }
            ...
        }
--- Locally Scoped

        pipeline {
            ...
            stages{ 
                stage('Scale by 10x') {
                            environment {
                                MAX_SIZE = 100
                                MIN_SIZE = 10
                            }
                            steps {
                                echo "MAX_SIZE = ${env.MAX_SIZE}"
                                echo "MIN_SIZE = ${env.MIN_SIZE}"
                            }
                }
                ...
            }
        }
- We can reference the variables in the following any ways..
- `env.VAR_NAME or VAR_NAME or $env.VAR_NAME or $VAR_NAME or ${env.VAR_NAME} or ${VAR_NAME}`
- Example as below...
- 
        pipeline {
            agent any
            environment {
                MAX_SIZE = 10
                MIN_SIZE = 1
            }
            stages {
                stage('Default Scale') {
                    steps {
                        echo "MAX_SIZE = ${env.MAX_SIZE}"
                        echo "MIN_SIZE = ${env.MIN_SIZE}"
                    }
                }
                stage('Scale by 10x') {
                    environment {
                        MAX_SIZE = 100
                        MIN_SIZE = 10
                    }
                    steps {
                        echo "MAX_SIZE = ${env.MAX_SIZE}"
                        echo "MIN_SIZE = ${env.MIN_SIZE}"
                    }
                }
            }
        }

######currentBuild Variables
- currentBuild variables allow pipeline steps to reference the state of a build while it's running. 
- This can be useful for dynamic operations that need to do something specific based on a previous step or a certain status in the build.
-  All of the currentBuild variables are actually properties of one variable named `currentBuild`.
- Please note that this variable is case sensitive. It starts with a lowercase c and the B in build is capitalized. 
- To access the currentBuild properties the values are proceeded by currentBuild, a dot and then the name of the property. The properties are also case sensitive and follow the CamelCase format with a lower case letter to start, and capital letters for each additional word in the variable name.
- A few examples of currentBuild variables are the start time, the duration of the build and the current status of the build. Just like environment variables, these values need to be proceeded by a dollar sign if they are used in strings.

######Parameter Variables
- Parameters are another type of variable that get their values at the time the `job is triggered`.
-  Parameters are defined in a `parameters block`, which is placed at the beginning of the pipeline code. 

        pipeline {
            agent any
            parameters {
            …
            }
            …
        }
- Much like we've seen with environment variables, parameters are accessed by their name proceeded by the params prefix. And if they're used in a string, they need to have a dollar sign at the beginning and can also be wrapped in curly braces. 

        params.PARAMETER_NAME
        “${params.PARAMETER_NAME}”
- Each parameter definition must include `a name, a default value, and a description` that explains the type of value that should be entered. Typically parameter names are assigned using all capital letters, so they can be easily identified in the code. 
- For pipelines, there are five different types of parameters we can use. `Strings, blocks of text, booleans, choices, and passwords`. 
- String and text parameters are represented by a text field in the Jenkins interface, where a user can enter freeform text. String parameters are best used for single word values. Text parameters are useful if you need to pass in a long block of text that contains multiple lines. 
- Boolean parameters let us pass in true or false values and are represented by a check mark in the Jenkins interface. 
- Choice parameters present the user with a list of options to choose from. When we create a choice parameter, the options are entered as a list. We don't have to specify a default though because the first value in this list will be used as the default value in the Jenkins interface. 
- Password parameters can be used to enter sensitive values like passwords and API keys. Password values are entered in the same way that string parameters are entered. However, password values are masked to keep them from being exposed. 
- Because pipeline parameters can change the Jenkins interface, it causes a sort of chicken and egg scenario. We can create a pipeline that defines parameters, but those parameters are not immediately available to the Jenkins job. So after you create a pipeline with parameters, you'll need to run the pipeline, which will actually encounter an error, especially if the default values are blank or aren't available for the job to process. But once the job is run a second time, the parameters will be available to be used. 
- This is also the case if parameters are added or changed. If you modify or add a parameter, the pipeline will need to be run once before the change is applied. 

        pipeline {
            agent any
            parameters {
                string(name: 'FATHER',
                    defaultValue: 'Vader',
                    description: 'Enter Your father’s name')

                text(name: 'PHRASE',
                        description: 'Enter your favorite phrase from a Charles Dickens Book',
                        defaultValue: 'It was the best of times, it was the worst of times,\nit was the age of wisdom, it was the age of foolishness,\nit was the epoch of belief, it was the epoch of incredulity,\nit was the season of light, it was the season of darkness,\nit was the spring of hope, it was the winter of despair.')

                booleanParam(name: 'RUN_TESTS',
                        defaultValue: false,
                        description: 'Toggle this value to run tests.')

                choice(name: 'AWS_REGION',
                        choices: ['us-east-1', 'us-east-2', 'us-west-1', 'us-west-2'],
                        description: 'Select the AWS region for deployment.')

                password(name: 'DATABASE_PASSWORD',
                        defaultValue: 'DATABASE_PASSWORD',
                        description: 'Enter the database password')
            }
            stages {
                stage('Example') {
                    steps {
                        echo "I am your father.  My name is ${params.FATHER}"
                        echo "My favorite phrase is ${params.PHRASE}"
                        echo "Will I rule the universe? ${params.RUN_TESTS}"
                        echo "I live in ${params.AWS_REGION}"
                        echo "Can I tell you a secret? ${params.DATABASE_PASSWORD}"
                    }
                }
            }
        }

######Conditional Expressions
- When we're developing pipelines we might need to use logic to determine if a stage should be run or not. We might also need to add some sort of manual interaction to an automated process. 

        pipeline {
        agent any
        stages {
            stage('XYZ') {
                when {}
            }
        }
        }
- To set up a pipeline condition, we use the `when` keyword inside a stage block. The when block uses three built in conditions to determine if the steps in a stage should be run. The conditions are `branch, environment, and expression`. If the specified condition evaluates to true, then the stage will be allowed to run, otherwise the stage will be skipped. 

|Condition  |Syntax                                                       |
|:----------|:------------------------------------------------------------|
|branch     |`when { branch 'main' }`                                     |
|environment|`when { environment name: 'DEPLOY_TO', value: 'production' }`|
|expression |`when { expression { params.ENVIRONMENT == 'PRODUCTION' }}`  |


- Branch conditions are useful when the pipeline is interacting with a version control system like GitHub. This allows us to only run stages for specific branches in a repo. 
- Environment conditions evaluate to true, if the specified environment variable is present and it contains the specified value. This can be useful for building projects that interact with different environments. 
- Expression conditions provide the most flexibility for conditional statements. We can use `groovy expressions` along with parameters and other variables to build a statement that returns true or false. 
- Along with conditionals, we can use the `input` step to control the flow of a pipeline. The input step pauses a triggered pipeline and waits for manual interaction to determine if the pipeline should proceed, or abort. We can also configure an input step with a custom message to give more information on what will happen if the job were to proceed. 

        pipeline {
        agent any
        stages {
            stage('XYZ') {
                steps {
                    input message: 'Confirm deployment to production...', ok: 'Deploy'
                }
            }
        }
        }

- Example using conditional and manual approval

        pipeline {
            agent any
            parameters {
                choice(name: 'ENVIRONMENT',
                    choices: ['DEVELOPMENT' , 'STAGING', 'PRODUCTION'],
                    description: 'Choose the environment for this deployment')
            }

            stages {
                stage ('Build') {
                    steps {
                        echo "Building..."
                    }
                }
                stage ('Deploy to non-production environments') {
                    when {
                        // Only deploy if the environment is NOT production
                        expression { params.ENVIRONMENT != 'PRODUCTION' }
                    }
                    steps {
                        echo "Deploying to ${params.ENVIRONMENT}"
                    }
                }
                stage ('Deploy to production environment') {
                    when {
                        expression { params.ENVIRONMENT == 'PRODUCTION' }
                    }
                    steps {
                        input message: 'Confirm deployment to production...', ok: 'Deploy'
                        echo "Deploying to ${params.ENVIRONMENT}"
                    }
                }
            }
        }


Jenkins with VCS
----------------
- Pipelines as Code with `Jenkinsfile` checked in code repo itself.

Jenkins can retrieve pipeline configurations from version control systems like GitHub.  In turn, GitHub can connect send webhooks to Jenkins that trigger jobs when a change is pushed to a repo.

To demonstrate connecting Jenkins and GitHub, the following need to be in place:
- A Jenkins server that is publicly accessible on the internet
- A GitHub account

Follow these steps to connect Jenkins to GitHub.

- Create a new pipeline project in your Jenkins server.
    - Select `New Item`
    - Enter item name (use the same name as your repo if possible)
    - Select `Pipeline` project
    - `OK`
    - Select `GitHub Project` and paste in the repo URL.
      - *NOTE: This step is optional.  It only creates a link to the repo on the project home page.*
    - Under `Build Triggers`, select the checkbox next to `GitHub hook trigger for GITScm polling`.
    - Under `Pipeline`, select `Pipeline script from SCM`.
    - Under SCM, select `Git`.
    - Under `Repository URL`, paste in the repo URL.
    - Under `Branch Specifier (blank for 'any')`, change `master` to `main`.
    - `Save` &rarr; `Build Now`.
    - *NOTE: The project must run at least one successful build before connecting to GitHub.  This allows Jenkins to read the configuration from the repo.*
    - Copy the URL of your Jenkins server.

- Go back to the GitHub repo and configure the settings to create a webhook for the project you just created.
  - Select `Settings` &rarr; `Webhooks` &rarr; `Add webhook`.
  - Under `Payload URL`, paste in the URL for your Jenkins server.
  - Immediately after the Jenkins server URL, add `/github-webhook/`.
  - *NOTE: Please be sure to include the trailing slash on `github-webhook/`.  The field should be in a format similar to `http://your-jenkins-server.com/github-webhook/`.*
  - Under `Content type`, select `application/json`.
  - `Add webhook`
  - *NOTE: GitHub will ping the Jenkins server and indicate a successful connection with a green checkmark next to the webhook name.  If your webhook does not indicate that it connected successfully, select `Edit` and confirm your settings again.  If needed, delete the webhook and start over.*
  - Select the `<>Code` tab.
  - Make a change to the README.md file.
    - Click the pencil icon.
    - Make a change to the file.
    - Click `Commit changes`.
  - Go to the Jenkins server and observe the job being triggered by the change you just made in GitHub.
  - *NOTE: If your job is not triggered, review the configuration for the Jenkins job and the GitHub repo, making any adjustments as needed.  If needed, start again with a new job in Jenkins or with a new webhook in GitHub.*

        pipeline {
            agent any

            // this section configures Jenkins options
            options {

                // only keep 10 logs for no more than 10 days
                buildDiscarder(logRotator(daysToKeepStr: '10', numToKeepStr: '10'))

                // cause the build to time out if it runs for more than 12 hours
                timeout(time: 12, unit: 'HOURS')

                // add timestamps to the log
                timestamps()
            }

            // this section configures triggers
            triggers {
                // create a cron trigger that will run the job every day at midnight
                // note that the time is based on the time zone used by the server
                // where Jenkins is running, not the user's time zone
                cron '@midnight'
            }

            // the pipeline section we all know and love: stages! :D
            stages {
                stage('Requirements') {
                    steps {
                        echo 'Installing requirements...'
                    }
                }
                stage('Build') {
                    steps {
                        echo 'Building..'
                    }
                }
                stage('Test') {
                    steps {
                        echo 'Testing..'
                    }
                }
                stage('Report') {
                    steps {
                        echo 'Reporting....'
                    }
                }
            }

            // the post section is a special collection of stages
            // that are run after all other stages have completed
            post {

                // the always stage will always be run
                always {

                    // the always stage can contain build steps like other stages
                    // a "steps{...}" section is not needed.
                    echo "This step will run after all other steps have finished.  It will always run, even in the status of the build is not SUCCESS"
                }
            }
        }

Pipelines can be used to call scripts that are stored in a repo along with a Jenkinsfile.

####Pipeline steps for calling scripts

The `sh()` build step is used to run shell commands on Linux, Unix, and macOS systems.

The `bat()` build step is used to run shell commands on Windows systems.

## Paths to scripts
Relative paths can be used to reference files from the root of the repo.
```
sh(‘./scripts/build.sh’)
bat(‘..\scripts\build.bat’)
```

Absolute paths can be used to reference files in the workspace or in other locations on the systems where the job is being run.
```
sh(‘/usr/local/bin/build.sh’)
bat(‘C:\bin\build.bat’)
```
The `dir()` build step can be used to change directories for other build steps.
```
dir("${env.WORKSPACE}/environments/test"){
sh(‘’’
    terraform init
    terraform plan
‘’’)
}
```


Agent and Distributed Build:
----------------------------
- The Jenkins server, which is also referred to as the Jenkins controller provides a web interface that we can use to manage the overall configuration of our Jenkins server. A best practice though, is to limit the jobs that are run on the controller, and only run jobs on other servers, which are referred to as nodes or agents. This approach frees up CPU, memory, and hard drive space on the Jenkins controller so it can use those resources for management tasks like scheduling jobs. 
- A node is another server or system that is connected to Jenkins over a network. Nodes provide the Jenkins controller with a compute resource for running jobs. When Jenkins starts a job on a node, the job is managed by a process called an agent. The agent runs the commands in the job definition, and reports the status back to the Jenkins controller. In reality, nodes and agents are different parts of a Jenkins system but you will often hear either term used to refer to an external system where Jenkins runs jobs. 
- There are many types of nodes and agents that Jenkins can use as compute resources. One of the most common node types is a secure shell or SSH node. In this case, Jenkins connects to a server as a specific user with an SSH key. This secure method is particularly useful if the node is not on the same network as the Jenkins controller. A server running any operating system can be configured as an SSH node as long as it accepts SSH connections has a user and a key that Jenkins can use, and also has a recent version of Java installed. Having Java installed on the node is essential because the agent process is a Java-based application. 
- Jenkins can also use nodes and agents that run as containers also known as Docker agents. With Docker agents, the Jenkins controller runs jobs in a newly created container on each build. This has the benefit of the job running in a fresh and isolated environment every time. 
- For Docker agents to work, a Docker process must be running on the node. When we start using nodes, and agents in pipeline jobs, there are some things we have to keep in mind. 
- First, we have to pay more attention to the agent configuration. So far we've been using agent any, which allows Jenkins to run the job on the first available agent. But as we start adding nodes, and agents with different capabilities, we can use labels or keywords that identify a specific agent. We may also need to configure a pipeline to install any tools that it needs to run. This will give a pipeline more control over the version of a specific tool while also making sure the tool is available to use. 
- Another thing we need to pay attention to is checking out code when a job is associated with a repository. When Jenkins uses a pipeline from a repository, the first checkout is on the Jenkins controller. This allows Jenkins to read and process the Jenkins file to get the project configuration. When Jenkins starts running the job on an agent, the code that was initially checked out won't be available. In this case, the pipeline needs to be updated with a step to check out the code so that it can be used on the agent.