# StaticLaunch 

StaticLaunch is an Infrastructure as Code (IaC) project that provisions and deploys a static website on Amazon S3 using Terraform.

The project demonstrates foundational AWS cloud infrastructure concepts including:

* Infrastructure as Code with Terraform
* AWS S3 Static Website Hosting
* Bucket Policies
* Public Access Configuration
* Website Endpoint Configuration
* Resource Outputs
* Terraform State Management

---

## Architecture Overview

The infrastructure consists of:

* AWS S3 Bucket
* S3 Website Hosting Configuration
* Public Access Block Configuration
* Bucket Ownership Controls
* Public Read Bucket Policy
* Static Website Assets

The deployed website serves:

* `index.html`
* `error.html`

---

## Project Structure

```text
StaticLaunch/
│
├── provider.tf
├── variables.tf
├── main.tf
├── outputs.tf
├── terraform.tfvars
│
├── website/
│   ├── index.html
│   └── error.html
│
├── README.md
├── ARCHITECTURE.md
└── .gitignore
```

---

## Prerequisites

Before deployment ensure the following are installed:

### Terraform

Verify installation:

```bash
terraform version
```

### AWS CLI

Verify installation:

```bash
aws --version
```

### AWS Credentials

Configure credentials:

```bash
aws configure
```

Provide:

```text
AWS Access Key ID
AWS Secret Access Key
Region
Output Format
```

Verify access:

```bash
aws sts get-caller-identity
```

---

## Configuration

Update `terraform.tfvars`:

```hcl
bucket_name = "your-unique-bucket-name"
```

Bucket names must be globally unique across AWS.

---

## Initialize Terraform

```bash
terraform init
```

---

## Validate Configuration

```bash
terraform validate
```

---

## Review Deployment Plan

```bash
terraform plan
```

---

## Deploy Infrastructure

```bash
terraform apply
```

Confirm with:

```text
yes
```

---

## View Outputs

After successful deployment:

```bash
terraform output
```

Example:

```text
website_url = staticlaunch-demo.s3-website-us-east-1.amazonaws.com
```

---

## Access the Website

Open:

```text
http://<website_url>
```

Example:

```text
http://staticlaunch-demo.s3-website-us-east-1.amazonaws.com
```

---

## Destroy Infrastructure

Remove all resources:

```bash
terraform destroy
```

Confirm:

```text
yes
```

---

## Learning Objectives

This project demonstrates:

* AWS S3 Static Website Hosting
* Terraform Resource Management
* Terraform State Handling
* AWS IAM Authentication
* Bucket Policy Configuration
* Infrastructure Deployment Automation

---

## Future Enhancements

Planned upgrades include:

* Terraform Remote State
* DynamoDB State Locking
* CloudFront CDN
* Route53 Custom Domain
* HTTPS via ACM
* GitHub Actions CI/CD
* Reusable Terraform Modules

---

## Author

**Emmanuel Mwangangi**

Software Engineer | Cloud Enthusiast | Solutions Architect

GitHub: https://github.com/Emmauzishakes
