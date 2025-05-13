
# Getting Started

This guide will help you get started with provisioning a Spark cluster on AWS using Terraform and Ansible.

## Step 1: Terraform - Provision Infrastructure

1. Navigate to the `terraform/` directory:
   
   ```bash
   cd terraform
   ```

2. Initialize Terraform:
   
   This will initialize the Terraform working directory and download the necessary provider plugins.

   ```bash
   terraform init
   ```

3. Apply the Terraform configuration:

   Terraform will provision the necessary AWS resources such as EC2 instances, VPC, security groups, etc.

   ```bash
   terraform apply
   ```

   During this step, Terraform will prompt you to confirm that you want to create the resources. Type `yes` and press enter to proceed. Terraform will then provision the resources and output the public IP addresses of the created EC2 instances.

---

## Step 2: Generate Inventory for Ansible

After provisioning the infrastructure with Terraform, the next step is to generate an Ansible inventory file that lists the public IPs of the EC2 instances.

1. Navigate to the `scripts/` directory:

   ```bash
   cd scripts
   ```

2. Run the Python script to generate the inventory file:

   ```bash
   python generate_inventory.py
   ```

   This script will dynamically create the `inventory.ini` file, which contains the list of public IPs for the EC2 instances provisioned by Terraform.

---

## Step 3: Ansible - Configure Spark Cluster

Once the inventory file is generated, you can proceed with configuring the Spark cluster using Ansible.

1. Navigate to the `ansible/` directory:

   ```bash
   cd ansible
   ```

2. Run the Ansible playbook to configure the EC2 instances:

   ```bash
   ansible-playbook -i inventory.ini playbook.yml --private-key ~/.ssh/instance_key.pem -u ubuntu
   ```

   Explanation:
   - `-i inventory.ini`: Specifies the inventory file generated in Step 2.
   - `playbook.yml`: The main playbook to configure the Spark cluster on the EC2 instances.
   - `--private-key ~/.ssh/instance_key.pem`: Path to your private key used to SSH into the EC2 instances.
   - `-u ubuntu`: The user to connect as (typically `ubuntu` for Ubuntu-based EC2 instances).

   Ansible will connect to each instance listed in the `inventory.ini` file and execute the configuration steps defined in the `playbook.yml`.

