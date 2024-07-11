# E2E-1-tire-Devops
Deploy simple application on AWS, create a CI/CD pipeline in Jenkins manage infrastructure using Terraform, Build application using maven and create docker images publish it in ECR and deploy it in EKS

1. Provision infrastructure using terraform

   terraform init

   terraform plan

   terraform apply --auto-approve

3. SSH to created eC2 instance

    ssh -i "<.pem file> <user@ipaddress>


4. Validate jenkins is installed and up and running

    sudo systemctl status jenkins

    To stop jenkins service
        sudo systemctl stop jenkins

    To start jenkins service
        sudo systemctl start jenkins


5. Provide sudo permission to jenkins user

    sudo visudo

    jenkins ALL=(ALL) NOPASSWD: ALL

    save the file

6. Switch to Jenkins user

    sudo su - jenkins


7. Install Docker in Jenkins user

    for pkg in docker.io docker-doc docker-compose docker-compose-v2    podman-docker containerd runc; do sudo apt-get remove $pkg; done
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/   keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/  docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io  docker-buildx-plugin docker-compose-plugin

8. Add docker user group

    sudo usermod -aG docker $USER

9. Restart the instance


10. Install eksctl

    # for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
    ARCH=amd64
    PLATFORM=$(uname -s)_$ARCH

    curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/    eksctl_$PLATFORM.tar.gz"

    # (Optional) Verify checksum
    curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/ eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

    tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

    sudo mv /tmp/eksctl /usr/local/bin


11. Install kubectl

    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/ bin/linux/amd64/kubectl
    chmod +x kubectl
    mkdir -p ~/.local/bin
    mv ./kubectl ~/.local/bin/kubectl

12. Install awscli

    sudo apt install awscli

13. Configure aws

    aws configure

14. Create eks cluster

    eksctl create cluster --name my-cluster5 --region us-east-1 --nodes 2 --node-type t3.medium --managed

15. Access jenkins on port 8080 and follow the installation steps

16. Create a admin user for jenkins

17. Install required plugins
 - SonarQube Scanner
 - Artifactory

17. Add Sonarcloud credentials and jfrog credentials as secret text to Jenkins Credentials

    SonarCloud

    MyAccount -> Security -> Generate Token

    Jfrog

    Administration -> User Management -> Access Token -> Generate Token

    Jenkins

    Manage Jenkins -> Credentials -> System -> Global credentials (unrestricted) -> New credentials

18. Update Jenkins system settings

    Provide SonarQube installation information
    Name - sonar-server
    Server URL - https://sonarcloud.io
    server authentication token - <provide_credential_name_which_was_added>


19. Update Jenkins Tool setting

    Provide SonarQube Scanner installations
    Name - sonar-scanner

    Provide Maven installations
    Name - maven3

20. Create a job (Pipeline)

21. Update pipeline configuration
    Provice SCM - Githib repository URL
     (provide github credentils if you are working with private repository)
    Specify the branch (for example: */main)

22. Login to AWS management console
    Create ECR (Elastic Container Registry)

23. Update the Registry Push commands in Jenkins file

24. Update the Registry image name with tag in Kubernetes-deployment.yaml file
    <imagename>:<tag>

25. Enable Webhooks in Github
    Navigate to repository
    Settings -> Webhooks -> Add webhook
    Payload URL - <Provide Jenkins URL> (for example: 127.0.0.0:8080/)
    Content type - application/json
    Which events would you like to trigger this webhook? - Send me everything.

26. Click on Build now in Jenkins

27. Select the build and click on Pipeline Console (or) Console Output for the pipeline progress


