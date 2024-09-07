# Infrastructure Deployment using Terraform, Helm, and GitHub Actions

## Overview

This repository contains configurations and scripts for deploying and managing infrastructure using **Terraform** and **Helm**, with **CI/CD pipelines** managed by **GitHub Actions**. It focuses on deploying an AWS EKS (Elastic Kubernetes Service) cluster, associated resources, and deploying applications using Helm charts. It also provides automation workflows for infrastructure management. While an example for **ECR** (Elastic Container Registry) automation with Helm charts is provided, this functionality is not actively implemented in the current configuration.

## Repository Structure

- **`terraform/`**: Contains Terraform configuration files for provisioning AWS resources.
- **`redis-helm-chart/`**: Contains Helm charts used for deploying applications to the EKS cluster.
- **`.github/`**: Contains GitHub Actions workflows for CI/CD.

## Infrastructure Provisioning Using Terraform

### Description

**Terraform** is utilized for creating and managing AWS infrastructure, including EKS clusters, VPCs, security groups, IAM roles, and other essential resources.

### Configuration

- **EKS Cluster**: Configured in private subnets without using Terraform modules.
- **VPC**: Custom VPC setup.
- **Security Groups**: Defined to control access to the EKS cluster.
- **IAM Roles**: Provisioned for EKS and other AWS services.
- **EFS (Elastic File System)**: Configured for persistent storage.

### Architecture

The Terraform configuration provisions the following architecture:
- A **VPC** with two public and two private subnets.
- A **NAT Gateway** to enable outbound internet access for private subnet resources.
- An **EKS Cluster** in private subnets for enhanced security and isolation.

#### Key Components

- **VPC**: A virtual network to isolate resources.
- **Public Subnets**: Subnets with direct internet access, used for load balancers or bastion hosts.
- **Private Subnets**: Subnets without direct internet access, used for EKS nodes.
- **NAT Gateway**: Enables private subnet resources to access the internet while preventing inbound traffic.

---

# EKS Cluster with EFS CSI Driver for Persistent Storage

## Overview

This setup integrates an Amazon **Elastic Kubernetes Service (EKS)** cluster with the **Amazon Elastic File System (EFS)** using the **Container Storage Interface (CSI) driver**. The EFS CSI driver provides persistent, scalable file storage for Kubernetes applications by allowing them to mount EFS file systems.

### Components

- **EKS Cluster**: A managed Kubernetes service running in private subnets.
- **EFS**: A fully managed, elastic file storage system.
- **EFS CSI Driver**: A Kubernetes driver that allows pods to mount EFS file systems for persistent storage.

### Architecture

- **EKS Cluster**: Hosted within private subnets.
- **EFS File System**: Provides persistent storage for Kubernetes pods.
- **EFS CSI Driver**: Manages the lifecycle of EFS volumes, allowing Kubernetes pods to attach and mount file systems.

### Persistent Storage with EFS

- **PersistentVolume (PV)**: Represents storage in the cluster, backed by EFS.
- **PersistentVolumeClaim (PVC)**: Requests storage for applications, specifying size and access modes. The PVC is bound to an appropriate PV.

#### Security Considerations

- **Security Groups**: Ensure the EFS security group allows NFS traffic (port 2049) from the EKS nodes' security group.
- **IAM Roles**: EKS nodes need an IAM role with the `AmazonEFSClientFullAccess` policy for EFS interactions.

## Conclusion

This setup with EFS provides reliable, scalable, and persistent storage for your Kubernetes applications, allowing data to persist across pod lifecycles.

---

# Helm for Application Deployment

### Description

**Helm** is used for deploying and managing applications on the EKS cluster. The repository contains Helm charts for managing the deployment of applications like **Redis**.

### Helm Charts

- **Redis**: Helm chart for deploying a Redis cluster.

### Deployment

- **Release Name**: Helm uses the folder name from the `helm` directory as the release name for the chart.

#### Redis Deployment

To update the Redis cluster, simply update the `image` in the `values.yaml` file and run a Helm upgrade. Helm will handle the update process without downtime.

---

# GitHub Actions for CI/CD Automation

### Description

GitHub Actions automate the infrastructure deployment, image building, and Helm chart deployment processes.

### Workflows

This repository contains three primary workflows:

1. **`.github/workflows/infra-provisioning.yml`**: Provisions infrastructure using Terraform.
   - **`terraform-prepare`**: Automatically triggered on push or pull request to the main branch. Prepares the Terraform environment.
   - **`terraform-apply`**: Manually triggered using `workflow_dispatch`. Applies the Terraform configuration.
   - **`terraform-destroy`**: Manually triggered using `workflow_dispatch`. Destroys Terraform-managed infrastructure.

2. **`.github/workflows/build-and-push.yml`**: Builds and pushes Docker images to an ECR repository.
   - **Note**: This is an example, and the ECR automation is not fully implemented for Helm charts.

3. **`.github/workflows/helm-deploy.yml`**: Deploys Helm charts to the EKS cluster.
   - **Helm Charts**: Deployed from the `redis-helm-chart` folder using a Helm workflow file.

---

# New Relic Integration with EKS Cluster

**New Relic** is used to monitor the AWS EKS cluster and Kubernetes applications. This guide provides both **manual** and **Terraform** integration methods.

## Prerequisites

1. **AWS Account**: Credentials for AWS.
2. **New Relic Account**: New Relic license key and account access.
3. **EKS Cluster**: A running EKS cluster.
4. **Terraform**: Installed and configured for infrastructure management.
5. **Helm**: Installed for Kubernetes package management.
6. **kubectl**: Installed to interact with the Kubernetes cluster.

## Integration Methods

### Method 1: Terraform Integration

**Terraform** automates the setup of AWS resources and the deployment of New Relic agents.

1. Terraform configurations for New Relic are available in the repository.
2. Follow the instructions in the provided Terraform files to deploy New Relic automatically.

### Method 2: Manual Integration

Manual integration involves using Helm to deploy New Relic agents directly to the EKS cluster.

1. Add the New Relic Helm repository:
   ```bash
   helm repo add newrelic https://helm-charts.newrelic.com
   helm repo update
   ```

2. Create a `values.yaml` file for New Relic:
   ```yaml
   newrelic-infrastructure:
     licenseKey: "<YOUR_NEW_RELIC_LICENSE_KEY>"
     clusterName: "<YOUR_CLUSTER_NAME>"
   ```

3. Deploy New Relic:
   ```bash
   helm install newrelic-infrastructure newrelic/newrelic-infrastructure -f values.yaml
   ```

Both methods provide real-time monitoring and observability for your Kubernetes applications.

---

## Conclusion

This repository provides a complete setup for deploying AWS infrastructure, managing Kubernetes applications using Helm, and automating the process with GitHub Actions. It also integrates monitoring with New Relic to ensure that your applications are running optimally.

--- 



