## Final project description. Intro to DevOps

Build CI/CD solution for Java project that is built by Maven.

## Release part, components:

- Jenkins 2.x with Pipeline plugin, Git, Docker and Nexus integration
- Nexus 3 OSS, as Maven artifact repository and Docker registry
- Github

Jenkins master, Jenkins slave instance and Nexus should be provisioned by Ansible roles.

Create Nexus proxy for Maven, Maven release and snapshot repos. Set Maven repo in Jenkins (Maven plugin settings). Create two Docker registries: first for snapshot versions, second for release. Release registry should avoid redeploys (versions should be unique)

Application: PetClinic (https://github.com/spring-projects/spring-petclinic), which is hosted on GitHub. Use default settings for the database (by default it uses an in-memory database).  

Fork PetClinic repo before start working.

Create Jenkins jobs which do the following:

## PreCommit job:

- watch for changes being pushed to review to any branch;
- build project with Maven, including unit tests (if any);
- should NOT upload artifacts to Nexus.
 

## Build job:

- watch for updates on "dev" branch;
- build project with Maven, including unit tests (if any);
- on successful build:
- upload artifacts to Nexus (snapshots repository);
- build Docker image with snapshot artifact and upload it to Nexus Docker  snapshot registry. Tag image like: petclinic:artifact-version (e.g petclinic:1.0.0-SNAPSHOT).

## Deployment job:

- triggers by Build job;
- receive artifact version as parameter from Build job;
- run Docker container on the slave instance. Make sure that you are able to open the PetClinic start page on 80 port.

## Promotion job:

- triggers manually;
- take project version as input parameter;
- Maven should perform "release:perform";
- change project version to release one;
- upload artifact(s) to Nexus (release repository);
- Build Docker image with released artifact (pulls proper version from Nexus release repo). Tag it like: petclinic:release-artifact-version (e.g. petclinic:1.0.0) and push it to Nexus Docker release registry.

## Solution
Project implementing in GPC.

Architecture diagram:
![Architecture diagram](https://github.com/atrofymchuk/final_task_intro_devops/blob/main/diagrams/Into_to_DevOps_Architecture_diagram.drawio.png)

By Terraform I created infrastructure in GCP.

This folder [tf_infra_env](https://github.com/atrofymchuk/final_task_intro_devops/tree/main/tf_infra_env) for create Nexus and Jenkins instances.

This folder [tf_dev_env](https://github.com/atrofymchuk/final_task_intro_devops/tree/main/tf_dev_env) for create app instance.

Infrastructure diagram:

![Infrastructure diagram](https://github.com/atrofymchuk/final_task_intro_devops/blob/main/diagrams/Into_to_Devops_Infrastructure_diagram_final_task.drawio.png)

For provisioning Jenkins and Nexus I used Ansible roles and playbook for provisioning [provisioner_infra.yml](https://github.com/atrofymchuk/final_task_intro_devops/blob/main/ansible/provisioner_infra.yml)

For provisioning App (slave Jenkins) I used Ansible roles and playbook for provisioning [provisioner_app.yml](https://github.com/atrofymchuk/final_task_intro_devops/blob/main/ansible/provisioner_app.yml)

Inventory file ```inventory_dev``` for App instance (slave Jenkins) and inventory file ```inventory_infra```  for Nexus and Jenkins built automaticly by Terraform but they don't host in Github.

For provisioning App instance I run command ```ansible-playbook -i inventory_dev provisioner_app.yml```

For provisioning Nexus and Jenkins I run command ```ansible-playbook -i inventory_infra provisioner_infra.yml```

## PreCommit job:

PreCommit job implemented by Jenkins in file [Jenkinsfile.precommit](https://github.com/atrofymchuk/final_task_intro_devops/blob/main/Jenkins/Jenkinsfile.precommit)

For watching changes being pushed to review to any branch I set up webhook from github to Jenkins.

## Build job:

Build job implemented by Jenkins in file [Jenkinsfile.build](https://github.com/atrofymchuk/final_task_intro_devops/blob/main/Jenkins/Jenkinsfile.build)

## Deployment job:

Deployment job implemented by Jenkins in file [Jenkinsfile.deployment](https://github.com/atrofymchuk/final_task_intro_devops/blob/main/Jenkins/Jenkinsfile.deployment)

## Promotion job:
Promotion job implemented by Jenkins in file [Jenkinsfile.promotion](https://github.com/atrofymchuk/final_task_intro_devops/blob/main/Jenkins/Jenkinsfile.promotion)
