Jenkins
=======

Introduction
------------
- The Jenkins continuous integration platform is one of the most capable and widely used automation frameworks in the world.
- In this course we'll look at advanced ways to use Jenkins.
- URL: https://www.jenkins.io/doc/

Prequisites
-----------
- Install Plugins
- Configure  Global Tools
- Create and run freestyle jobs
- Use parameters with Jobs
- Git (Github, Gitllab, BitBucket)

Jenkins and DevOps
------------------
- The DevOps Life Cycle consists of `eight stages` in the `planning, development, and operation` of a system, or software application. 
- The DevOps Life Cycle is presented as an infinity symbol because the cycle is continuous. Each step is repeated in order until the system or application is decommissioned. 
- The loop is divided into two groups with the first group representing the `development stages` of the cycle, and the second group representing the `operational stages`.
- In the **`development`** group we start with the stage labeled `plan` and then move on to `code`, `build` and `test`. 
- In the **`operations`** group we continue the cycle with `release`, `deploy`, `operate` and `monitor`.
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
- Jenkins supports `scripted` and `declarative` pipelines.
- Scripted pipeline starts with `node` block and uses Groovy based DSL.
- Declarative piplines starts with `pipeline` block and it is evolution of scripted pipline  and models the CI/CD with more readable syntax.

#####First Pipeline Example
- Go to `New Item` > Give a name > Then Select `Pipeline` Job type and OK.
- Go to job > Go to  `Pipeline` tab > Select definition `Pipeline script` > and in Script select `Hello World` from the `try sample pipeline` dropdown.
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

##### Creating a Declarative Pipeline
- Declarative pipeline must start with `pipeline` block.
- A declarative piplein  **required** to have an `agent` section, a `stages`section and at leat one `stage` section and at least one `steps` section.
- Above pipeline example is the **minimal** pipeline with required sections.
  
###### Agent
- `agents` section specifies the machine where the commands or more specifically stages, of pipline will run. We can use several parameter to specify the an agent.
- Some of the parameters as as `any`, `label`, `docker` and `none`.
- `any` : We are letting jenkins to run the pipeline on first available  executer. Generaly used when using controller as executer as well.
- `agent { label 'linux' }` : runs on the agent which have specified label.
- `agent { docker { image 'maven' } }` run the pipeline inside a docker container using specified image.When need fresh environment for each build.
- `agent none` : defer agent selection to stages.Allows to use diffrent agent for diffrent stages in pipeline.

###### Stages
- In the stages section of a pipeline, we identify specific parts of the process being automated. 
- If we were developing a CICD pipeline, for example, we could use stages named `build, test, and deploy` to represent the actions needed for an application deployment.
-  Each stage must contain at least one steps section. 
- In the steps section, we list the commands that actually do something. This is where we run programs, scripts and commands that interact with the compute platform that the pipeline is running. 
- We can have **multiple commands** in each step. Let's create a new pipeline that has multiple stages and steps.
  

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
- Test above pipeline by pasting in the script body in the piplein script in Jenkins job.

###### Piepeline Steps
- Stpes are the smallest unit and building blocks that runs to do actual work.
- Various plugins provide various steps for diffrent types of work.
- `echo` : Just print the message on console.
- `git` : Checkout repo from git repository
- `sh` : Run a script of local command
- `archiveArtifact` : Archive artifacts created by the Job
- Basic Steps reference: https://www.jenkins.io/doc/pipeline/steps/workflow-basic-steps/
- Additional Pipline stpes for tools and plugins: https://www.jenkins.io/doc/pipeline/steps/

##### Pipeline Snippet Generator
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
- Use the snippet generator to create a step for the following pipeline that archives all files ending with .txt:

##### Variables in Pipeline
- There are three types of variabes as `Environment, parameters` and `build`.


###### Environment Variables
- The Usual practice is to use all `CAPS` for enviornment varaibel.
- Can be scoped globally for entire pipeline or localy for a single stage.
--- Globally Scoped

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
- `env.VAR_NAME ` or `VAR_NAME` or `$env.VAR_NAME` or `$VAR_NAME` or `${env.VAR_NAME}` or `${VAR_NAME}`
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

###### currentBuild Variables
- currentBuild variables allow pipeline steps to reference the state of a build while it's running. 
- This can be useful for **dynamic** operations that need to do something specific based on a previous step or a certain status in the build.
-  All of the currentBuild variables are actually properties of one variable named `currentBuild`. 
- To access the currentBuild properties the values are proceeded by currentBuild, a dot and then the name of the property.
- A few examples of currentBuild variables are the start time.
- `currentBuild.duration`, `currentBuild.currentResult`
- This can be referenced in same ways as enviornment variables.

###### Parameter Variables
- Parameters are another type of variable that get their values at the time the `job is triggered`.
-  Parameters are defined in a `parameters block`, which is placed at the beginning of the pipeline code. 

        pipeline {
            agent any
            parameters {
            …
            }
            …
        }

- Much like we've seen with environment variables, parameters are accessed by their name proceeded by the params prefix(` params.PARAMETER_NAME`). 
- And if they're used in a string, they need to have a dollar sign at the beginning and can also be wrapped in curly braces(`“${params.PARAMETER_NAME}”`)

- Each parameter definition must include `a name, a default value, and a description` that explains the type of value that should be entered. Typically parameter names are assigned using all capital letters, so they can be easily identified in the code. 
- For pipelines, there are five different types of parameters we can use. `Strings, blocks of text, booleans, choices, and passwords`. 
-  
- Choice parameters present the user with a list of options to choose from. When we create a choice parameter, the options are entered as a `list`. We don't have to specify a default though because the first value in this list will be used as the default value in the Jenkins interface. 
- Password parameters can be used to enter sensitive values like passwords and API keys. However, password values are masked to keep them from being exposed. 
- Because pipeline parameters can change the Jenkins interface,.- - We can create a pipeline that defines parameters, but those parameters are not immediately available to the Jenkins job. So after you create a pipeline with parameters, you'll need to run the pipeline.
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

###### Conditional Expressions
- When we're developing pipelines we might need to use logic to determine if a stage should be run or not.
-  We might also need to add some sort of manual interaction to an automated process. 

        pipeline {
        agent any
        stages {
            stage('XYZ') {
                when {}
            }
        }
        }
- To set up a pipeline condition, we use the `when` keyword inside a stage block. 
- The when block uses three built in conditions to determine if the steps in a stage should be run. 
- The conditions are `branch, environment, and expression`. If the specified condition evaluates to true, then the stage will be allowed to run, otherwise the stage will be skipped. 

|Condition  |Syntax                                                       |
|:----------|:------------------------------------------------------------|
|branch     |`when { branch 'main' }`                                     |
|environment|`when { environment name: 'DEPLOY_TO', value: 'production' }`|
|expression |`when { expression { params.ENVIRONMENT == 'PRODUCTION' }}`  |


-  This allows us to only run stages for specific branches in a repo. 
- Environment conditions evaluate to true, if the specified environment variable is present and it contains the specified value. 
- Expression conditions provide the most flexibility for conditional statements. We can use `groovy expressions` along with parameters and other variables to build a statement that returns true or false. 
- Along with conditionals, we can use the `input` step to control the flow of a pipeline. The input step pauses a triggered pipeline and waits for manual interaction to determine if the pipeline should proceed, or abort.

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
- We can use Jenkins file to define `tools`, `options`, `triggers`, `agents`, `stages`, `post` etc.
- Jenkins can retrieve pipeline configurations from version control systems like GitHub. 
-  In turn, GitHub can connect send webhooks to Jenkins that trigger jobs when a change is pushed to a repo.


- Follow these steps to connect Jenkins to GitHub.

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

- Pipelines can be used to call scripts that are stored in a repo along with a Jenkinsfile.

##### Pipeline steps for calling scripts

- The `sh()` build step is used to run shell commands on Linux, Unix, and macOS systems.

- The `bat()` build step is used to run shell commands on Windows systems.

##### Paths to scripts
- Relative paths can be used to reference files from the root of the repo.
```
sh(‘./scripts/build.sh’)
bat(‘..\scripts\build.bat’)
```

- Absolute paths can be used to reference files in the workspace or in other locations on the systems where the job is being run.
```
sh(‘/usr/local/bin/build.sh’)
bat(‘C:\bin\build.bat’)
```
- The `dir()` build step can be used to change directories for other build steps.
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
- The Jenkins server, which is also referred to as the Jenkins controller provides a web interface that we can use to manage the overall configuration of our Jenkins server.
-  A best practice though, is to limit the jobs that are run on the controller, and only run jobs on other servers, which are referred to as nodes or agents.  
- A `node` is another server or system that is connected to Jenkins over a network. 
- Nodes provide the Jenkins controller with a compute resource for running jobs. 
- When Jenkins starts a job on a node, the job is managed by a process called an `agent`. The agent runs the commands in the job definition, and reports the status back to the Jenkins controller. 
- In reality, nodes and agents are different parts of a Jenkins system but you will often hear either term used to refer to an external system where Jenkins runs jobs. 
- There are many types of nodes and agents that Jenkins can use as compute resources. 
- One of the most common node types is a secure shell or `SSH` node. In this case, Jenkins connects to a server as a specific user with an SSH key. 
- This secure method is particularly useful if the node is not on the same network as the Jenkins controller. 
- Jenkins can also use nodes and agents that run as containers also known as Docker agents. With Docker agents, the Jenkins controller runs jobs in a newly created container on each build. This has the benefit of the job running in a fresh and isolated environment every time. 
- For Docker agents to work, a Docker process must be running on the node. When we start using nodes, and agents in pipeline jobs, there are some things we have to keep in mind. 
- **Another thing we need to pay attention to is checking out code when a job is associated with a repository. When Jenkins uses a pipeline from a repository, the first checkout is on the Jenkins controller. This allows Jenkins to read and process the Jenkins file to get the project configuration. When Jenkins starts running the job on an agent, the code that was initially checked out won't be available. In this case, the pipeline needs to be updated with a step to check out the code so that it can be used on the agent.**

Artifacts and Testing
---------------------
##### Artifacts and Finferprintimg
- When a Jenkins job creates an object that needs to be saved, we refer to that object as an artifact.
-  Artifacts can be compiled binaries like Docker images or ZIP files. Or an artifact might be a text file like a report or some sort of document. - The core function `archiveArtifacts`, gives us a built step for identifying the files we want to save during or after a build.
-  archiveArtifacts is often placed in the post section of a pipeline. The post block runs after all sections of a pipeline, so any steps inside the block are run after other operations have finished. 
-  If we're developing a job that needs to access an artifact created in another job, we can use build steps provided by the `Copy Artifact plugin`. - When we use the Copy Artifact's build step, security comes into play. The job that creates the artifact must include an option that gives another job explicit permission to copy the artifact. 
- When an artifact is created or used, Jenkins generates an MD5 checksum using the artifact. This becomes the file's fingerprint. 
- Jenkins can then use the fingerprint to determine what jobs either created or accessed a file.    

##### Test and code coverage reports
- Use code coverage and test reports plugins

Securing Jenkins
----------------
- Jenkins can be configured to use different `security realms`. Using a very brief explanation, a security realm controls how a person is authenticated to access a resource. 
- The default realm is a `user database` included in the Jenkins server. This is where Jenkins creates the first users with permission to access the system when the service is installed. 
- Jenkins can also delegate authorization to other realms, including Lightweight Directory Access Protocol services, also known as LDAP, or systems that use Unix-style users and groups. 
-  When Jenkins first starts, any authenticated user can do anything. This essentially means that any user that can log in is an administrator. 
- it's a best practice to have one or two administrative users and then delegate permissions to all other users based on how they need to interact with the Jenkins server. 
- Jenkins allows this to be configured fairly easily with matrix-based security. To configure user permissions, most Jenkins installations will use the Matrix Authorization Strategy plugin.
- Using a matrix strategy, permissions are assigned to each user individually. In addition, each user is given specific permission to perform certain actions.

#### Configurae Project Based Security
- Project Based Matrix

#### Using secrets and credentials
- Jenkins can store and manage sensitive values natively.

- Sensitive values are referred to as secrets or credentials.  Both terms are used with the same meaning in this course.

## Types of credentials
- Jenkins supports several types of credentials including
  - Usernames and passwords
  - SSH Keys
  - Files
  - Text strings

- Installing plugins may expose other types of credentials.

## Accessing credentials in a pipeline
- Credentials can be accessed several ways in a pipeline but the two most common ways are using the `credentials()` function or the `withCredentials(){}` step.

## Accessing credentials with credentials()
- The credentials function is used to assign sensitive values to one or more environment variables.  It takes the ID of a secret stored in Jenkins as its argument.

- With most credential types, `credentials()` will return one value.
```
environment {
    SECRET_VALUE = credentials(‘secret-value’)
}

env.SECRET_VALUE 
```

- However, when the credentials function is used with a username and password credential, three variables are returned.

```
environment {
    LOGIN = credentials(‘login’)
}

env.LOGIN
env.LOGIN_USR
env.LOGIN_PSW
```


## Accessing credentials with withCredentials(){}
- `withCredentials` is a build step that retrieves a secret value and assigns it to a variable.  Any steps that are placed inside the withCredentials step will have access to the secret.

```
steps {
    withCredentials([string(credentialsId: 'apikey', variable: 'API_KEY')]) {
        echo “${env.API_KEY}”
    }
}
```

## Example pipeline using credentials
- Use the following pipeline to experiment with accessing credentials.  

- Before running the pipeline, create two credentials:

  - `user1` using the "Username and password" type
  - `apikey` using the "Secret text" type
  
- Review the output after running the pipeline to note any references to the values the credentials contain.

```Jenkinsfile
pipeline {
    agent any
    environment {
      USER1 = credentials('user1')
    }
    stages {
        stage('Test') {
            steps {
                withCredentials([string(credentialsId: 'apikey', variable: 'APIKEY')]) {
                    echo env.APIKEY
                    echo env.USER1
                    echo env.USER1_USR
                    echo env.USER1_PSW

                    // This should cause a warning
                    echo "${env.APIKEY}"
                }
            }
        }
    }
}
```