# DevSecOps - CI/CD Pipeline
### Tools Used 
- Java - Programming
- SpringBoot - Spring framework
- Git - Version control
- Jenkins - Continuous Integration
- Maven -Build Tool
- Junit - Test
- SonarQube - Static Code Analysis
- Docker - Containerization
- Trivy -  Security And Misconfiguration Scanner
- Slack - Messaging
- Hashicorp Vault - Secrets And Encryption Management Tool

### Installation Links 

**Jenkins**  - https://pkg.origin.jenkins.io/debian/

**Sonar	Qube + PostgresSQL** - https://www.fosstechnix.com/how-to-install-sonarqube-on-ubuntu-22-04-lts/ & https://www.digitalocean.com/community/tutorials/opening-a-port-on-linux

**Docker** https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository

**Trivy** https://aquasecurity.github.io/trivy/v0.40/getting-started/installation/

**Hashicorp** https://www.cyberithub.com/how-to-install-hashicorp-vault-on-ubuntu-20-04-lts/

### Architecture
![DevSecOps](https://github.com/aditi55/DevOps/assets/67974030/e869b60e-e7a3-4cd2-84a1-a9e08086b683)

Pipeline flow:
1.	Jenkins will fetch the code from the remote repo
2.	Maven will build the code, if the build fails, the whole pipeline will become a failure and Jenkins will notify the user, If build success then
3.	Junit will do unit testing, if the application passes test cases then will go to the next step otherwise the whole pipeline will become a failureJenkins will notify the user that your build fails. 4.SonarQube scanner will scan the code and will send the report to the SonarQube server, where the report will go through the quality gate and gives the output to the web Dashboard. In the quality gate, we define conditions or rules like how many bugs or vulnerabilities, or code smells should be present in the code. Also, we have to create a webhook to send the status of quality gate status to Jenkins. If the quality gate status becomes a failure, the whole pipeline will become a failure then Jenkins will notify the user that your build fails.
4.	After the quality gate passes, Docker will build the docker image. if the docker build fails when the whole pipeline will become a failure and Jenkins will notify the user that your build fails.
5.	Trivy will scan the docker image, if it finds any Vulnerability then the whole pipeline will become a failure, and the generated report will be sent to s3 for future review and Jenkins will notify the user that your build fails.
6.	After trivy scan docker images will be pushed to the docker hub, if the docker fails to push docker images to the docker hub then the pipeline will become a failure and Jenkins will notify the user that your build fails.
7.	After the docker push, Jenkins will create deployment and service in minikube and our application will be deployed into Kubernetes. if Jenkins fails to create deployment and service in Kubernetes, the whole pipeline will become a failure and Jenkins will notify the user that your build fails.
