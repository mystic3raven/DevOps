# DevSecOps - CI/CD Pipeline

**Project Title:** DevSecOps CI/CD Pipeline Implementation

**Project Description:**

In today's software development landscape, security and continuous integration/continuous deployment (CI/CD) have become paramount. The "DevSecOps CI/CD Pipeline" project is a comprehensive solution that ensures the seamless integration of security practices into the development and deployment pipeline. Leveraging key technologies like Java, Maven, Git, Jenkins, Trivy, SonarQube, Docker, HashiCorp Vault, and Slack, this project is designed to elevate the security, quality, and efficiency of software development and delivery.

**Key Components and Technologies:**

1. **Java & Maven:**
   - Utilizing Java and Maven for building and packaging applications.
   
2. **Git:**
   - Leveraging Git for version control, ensuring code management and collaboration are streamlined.

3. **Jenkins:**
   - Implementing Jenkins for automation, enabling continuous integration and continuous deployment.

4. **Trivy:**
   - Integrating Trivy, a vulnerability scanner for containers, to identify and remediate security issues in Docker images.

5. **SonarQube:**
   - Implementing SonarQube for code quality analysis and continuous inspection, ensuring the codebase is free from vulnerabilities and technical debt.

6. **Docker:**
   - Docker is used for containerization, allowing for consistent and reproducible deployments across environments.

7. **HashiCorp Vault:**
   - Integrating HashiCorp Vault for managing secrets, keys, and other sensitive information, enhancing security and compliance.

8. **Slack:**
   - Utilizing Slack for real-time communication and notifications, keeping the development and operations teams informed.

**Project Goals and Outcomes:**

- **Automated CI/CD:** The primary goal is to establish a fully automated CI/CD pipeline, reducing manual intervention and speeding up the software delivery process.

- **Security-Centric:** This pipeline is security-centric, with Trivy and SonarQube continuously monitoring for vulnerabilities and code quality issues.

- **Secrets Management:** HashiCorp Vault ensures secure storage and management of secrets, minimizing security risks.

- **Enhanced Collaboration:** Git and Slack promote seamless collaboration among team members, fostering a culture of shared responsibility and transparency.

- **Scalability:** The pipeline is designed to be scalable, accommodating the evolving needs of the project and allowing for easy integration of additional tools and services.

- **Quality Assurance:** With SonarQube in place, the codebase is constantly reviewed for best practices, ensuring the highest code quality.

The "DevSecOps CI/CD Pipeline" project aligns development, security, and operations teams to create a unified, efficient, and secure pipeline that facilitates the delivery of high-quality software. This project not only streamlines the development process but also safeguards the application against potential security threats, thus providing a robust and secure foundation for software deployment.
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
