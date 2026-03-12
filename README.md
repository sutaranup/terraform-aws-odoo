# Terraform AWS Odoo Deployment

---

## 🏗️ How It Works

The infrastructure as code (IaC) handles the following:

* **Instance Provisioning:** Launches an Amazon EC2 instance running **Ubuntu 24.04 (Noble)**.


* **Networking:** Uses the default VPC and attaches an **Elastic IP (EIP)** to ensure a persistent public IP address.


* **Security:** Creates a security group allowing inbound traffic on **Port 80 (HTTP)** and **Port 22 (SSH)**.


* **Automated Setup:** Uses an EC2 `user_data` script (`script.sh`) to automatically:
    1. Install Git, Docker, and Docker Compose.
    2. Clone the [odoo-docker](https://github.com/sutaranup/odoo-docker) repository.
    3. Generate a secure database password and launch the application.

---

## 🚀 Getting Started

### 1. Prerequisites

* An active AWS account.
* [**AWS CLI**](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed in your local machine with credentials configured.
* [**Terraform**](https://developer.hashicorp.com/terraform/install) installed on your local machine.
* An existing **S3 bucket** to store the Terraform state.



### 2. Initialization

You must initialize the project by providing your S3 backend details. This ensures your state file is stored securely and remotely.

```bash
terraform init \
  -backend-config="bucket=YOUR_BUCKET_NAME" \
  -backend-config="key=odoo/terraform.tfstate" \
  -backend-config="region=us-east-1"

```

> **Note:** Replace `YOUR_BUCKET_NAME` with your actual S3 bucket name.

### 3. Deployment

By default, the project uses a `t3.small` instance. You can customize this during the apply phase:

```bash
terraform apply -var="instance_type=t3.medium"

```

The configuration includes validation to ensure only `t3` series instances are used.

---

## 📊 Outputs

After a successful deployment, Terraform will output the connection details:

* **Instance Public IP:** The static Elastic IP.

* **Instance Public DNS:** The AWS-assigned DNS name.

Use these addresses in your browser to access the Odoo setup wizard on Port 80.

---

## 🛠️ Configuration Details

* **Provider:** AWS (`~> 6.0`).

* **Region:** Defaulted to `us-east-1`.

* **.gitignore:** Pre-configured to ignore local `.terraform` files, `.tfstate`, and sensitive `.tfvars` files.

---

## ⚖️ License

This project is released under the **Unlicense**, making it free and unencumbered software released into the public domain. You are free to copy, modify, and distribute it for any purpose. See the [LICENSE](https://unlicense.org/) file for more details.