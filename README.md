# 🚀 CI/CD Pipeline with Jenkins, Docker & Kubernetes on AWS EKS 

This project demonstrates a **production-ready CI/CD pipeline** that:
- Builds a Java 21 application using Maven
- Containerizes it using Docker
- Pushes versioned images to Docker Hub
- Deploys to a private AWS EKS cluster
- Performs zero-downtime rolling updates
- Automatically rolls back on failure

The pipeline simulates a real-world DevOps workflow with automated build, versioning, deployment, and recovery strategies.

---

## 🏗️ Infrastructure Provisioning (Terraform)

This project uses Terraform to provision AWS infrastructure in a modular and production-style architecture.

### 🔹 Infrastructure Components

- Custom VPC with public & private subnets
- Internet Gateway & Route Tables
- Bastion Host (Public EC2)
- Private EC2 Instance
- Private Amazon EKS Cluster
- IAM Roles & Instance Profiles
- Security Groups

### 📂 Terraform Structure

- Creat your own key pair in the folder `my-terraform/bastion-ec2/` and name it as `key-ec2`
```bash
    ssh-keygen
```
```
my-terraform
├── main.tf
├── modules
│   ├── bastion-ec2
│   │   ├── iam.tf
│   │   ├── key-ec2.example
│   │   ├── key-ec2.pub.example
│   │   ├── key-pair.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── script.sh
│   │   ├── security-grp.tf
│   │   └── variables.tf
│   ├── eks
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── security-grp.tf
│   │   └── variables.tf
│   ├── private-ec2
│   │   ├── iam.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── security-grp.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       └── output.tf
├── outputs.tf
├── provider.tf
├── terraform.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf
```

### 🚀 Deployment Steps

- Initialize
```
terraform init
```
- Validate
```
terraform validate
```
- Plan
```
terraform plan
```
- Apply
```
terraform apply -auto-approve
```

### 🏠 Terraform provisions:

- Secure networking layer
- Bastion access layer
- Private compute layer
- Fully configured EKS cluster

🔐 Security Design

- EKS endpoint configured as private
- Worker nodes in private subnets
- No direct public access to private EC2
- Bastion host used as secure jump server
- IAM roles used instead of static credentials

---

## 🖥️ Configuration Management (Ansible)

Ansible is used to automate server provisioning and tool installation after infrastructure creation.

### 🔹 Automation Tasks

- Install Docker
- Install Java 21
- Install AWS CLI
- Install Maven
- Install Kubectl
- Install Jenkins
- Configure system dependencies
- Prepare environment for CI/CD pipeline

### 📂 Ansible Structure

Configure the `inventory.ini` according to your Private EC2 IP and Private key location. 

```
├── my-ansible
│   ├── ansible.cfg
│   ├── aws-cli
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── docker-engine
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── inventory.ini
│   ├── jenkins
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── key-ec2
│   ├── kubectl
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── main.yml
│   ├── maven
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── setup
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   └── zip-unzip
│       ├── README.md
│       ├── defaults
│       │   └── main.yml
│       ├── files
│       ├── handlers
│       │   └── main.yml
│       ├── meta
│       │   └── main.yml
│       ├── tasks
│       │   └── main.yml
│       ├── templates
│       ├── tests
│       │   ├── inventory
│       │   └── test.yml
│       └── vars
│           └── main.yml

```

### 🚀 Run Playbooks

- Add the Private EC2 **host fingerprint** on the Bastion EC2
```
ssh ubuntu@<Private-IP-Of-Private-EC2>
```

```
ansible-playbook main.yml
```

---

## 📌 CI/CD Architecture Overview

```
Developer Commit
      |
   Jenkins
      |
      |-- Maven Build (JAR)
      |-- Docker Build & Push
      |-- kubectl Apply with Rollbacks
      |-- Rolling Update
 AWS EKS (Kubernetes)
      |
 LoadBalancer Service → Application
```
 
---

## 🧰 Tech Stack

- Java 21
- Maven
- Docker
- Jenkins
- Kubernetes
- AWS EKS
- AWS CLI
- Terraform
- Ansible

---

## ⚙️ Prerequisites

- AWS account
- Docker Hub account
- Jenkins credentials configured:
- Docker Hub credentials ID: `dockerhub-credentials`
- Create the appropriate namespace for the EKS cluster in the Private EC2 node
```
kubectl create namespace demo
```

---

## 🔄 Jenkins CI/CD Pipeline

### 📄 Jenkinsfile

The Jenkins pipeline performs the following stages:

### 1️⃣ Build JAR

- Executes Maven build:

```bash
mvn clean package -DskipTests

```

- Archives the generated JAR file

### 2️⃣ Docker Image Build

- Builds Docker image using Jenkins build number:

`app:v-${BUILD_NUMBER}`

### 3️⃣ Docker Image Push

- Logs in to Docker Hub using Jenkins credentials

- Tags the image:

  `manashbarman007/app:v-${BUILD_NUMBER}`


- Pushes the image to Docker Hub

- Logs out after push

### 4️⃣ Deploy to Kubernetes

- Applies Kubernetes manifests from the k8s/ directory

- Updates the Deployment image dynamically

- Waits for rollout completion

- Automatically rolls back on deployment failure

### 5️⃣ Cleanup

- Cleans unused Docker images and containers:

```bash
docker system prune -f

```

---

## ☸️ Kubernetes Configuration

### 🔹 Deployment

- Name: myapp

- Namespace: demo

- Replicas: 4

- Strategy: RollingUpdate

  `maxSurge: 25%`

  `maxUnavailable: 25%`

  `Container Port: 8081`

- Image updated dynamically by Jenkins

- Readiness Probe:

  `/actuator/health/readiness`


- Resource Requests:

  `CPU: 100m`

  `Memory: 100Mi`

- Resource Limits:

  `CPU: 500m`

  `Memory: 256Mi`

### 🔹 Service

- Name: myapp-svc

- Namespace: demo

- Type: LoadBalancer

- Exposes application on port `80`

- Routes traffic to container port `8081`

### 🚀 How to Deploy

- Run the setup script to install tools and create the EKS cluster

- Access Jenkins:

  `http://<server-ip>:8080`


- Create a Jenkins Pipeline job

- Configure SCM to point to this repository

- Trigger the pipeline

- Jenkins will:

   `Build the Java application`

   `Build and push Docker image`
  
   `Deploy application to EKS`

   `Perform zero-downtime rolling updates`

### 🔁 Rollback Strategy

- If deployment fails, Jenkins automatically executes:

``` bash
kubectl rollout undo deployment/myapp -n demo

```

This ensures fast recovery to the previous stable version.

### 🧯 Troubleshooting

- Docker permission denied

- Not logged out and logged in the machine after user was added to the docker group or run the below command as alternatice : 
  ``` bash
   newgrp docker
  ```

- kubectl not working in Jenkins

- Ensure AWS credentials are configured for the jenkins user

- Verify kubeconfig exists for Jenkins user

- Pods stuck in Pending or NotReady

``` bash
 kubectl describe pod <pod-name> -n demo

```

### ✨ Key Highlights

- End-to-end CI/CD automation

- Infrastructure provisioning + application deployment

- Jenkins-driven Docker image versioning

- Kubernetes rolling updates with readiness probes

- Automated rollback on failure

- Production-grade DevOps workflow

---

## 👨‍💻 Author
**Manash Barman**  
Backend Developer | Java, Spring Boot, Microservices  
[LinkedIn](https://www.linkedin.com/in/manash-barman-15b1833a1/) | [GitHub](https://github.com/manashbarman007-cmyk)

---



