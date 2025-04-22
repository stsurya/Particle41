# Particle41

````markdown
# 🚀 Dockerized Application

This is a simple Dockerized application. You can clone this repository, build the Docker image, and run the container exposing port **5000**.

## 🧾 Requirements

- Docker installed on your system

## 📦 Clone the Repository

```bash
git clone https://github.com/stsurya/Particle41.git
cd Particle41/app
```
````

## 🛠️ Build the Docker Image

```bash
docker build -t my-app .
```

## ▶️ Run the Docker Container

```bash
docker run -p 5000:5000 my-app
```

Now your app should be running and accessible at [http://localhost:5000](http://localhost:5000) 🚀

---

## 📁 Files Included

- `Dockerfile` – Defines how to build the app image
- `requirements.txt` – Python dependencies
- Application source code

---

Awesome! Here’s a `README.md` template tailored for a Terraform script that provisions:

- Azure Container Apps (ACA)
- Azure Application Gateway
- Virtual Networks (VNets)

This README assumes your repo contains the necessary `.tf` files, `variables.tf`, and optionally a `terraform.tfvars`.

---

````markdown
# 🌐 Azure Infrastructure with Terraform

This Terraform project provisions the following Azure resources:

- 🧱 Virtual Networks (VNet & Subnets)
- 🚀 Azure Container Apps (ACA)
- 🌐 Azure Application Gateway

---

## 🧰 Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- An [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) session authenticated
- A valid Azure subscription

---

## 🚀 Quick Start

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/stsurya/Particle41.git
cd Particle41/terraform
```
````

### 2️⃣ Initialize Terraform

```bash
terraform init
```

### 3️⃣ (Optional) Set Variables

Edit `terraform.tfvars` or pass variables via CLI:

```bash
terraform plan -var="resource_group_name=my-rg" -var="location=eastus"
```

### 4️⃣ Apply the Configuration

```bash
terraform apply
```

✅ Confirm the changes when prompted.

---

## 📁 Files

- `main.tf` – Defines resources for ACA, App Gateway, VNets
- `variables.tf` – Input variables for easy customization
- `terraform.tfvars` – Optional: define values for variables here

---

## 🔄 Destroy Resources

To tear down the infrastructure:

```bash
terraform destroy
```

---
