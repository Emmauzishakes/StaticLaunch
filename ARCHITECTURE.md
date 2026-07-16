# StaticLaunch Architecture

## Overview

StaticLaunch provisions an Amazon S3 bucket configured for static website hosting using Terraform.

The infrastructure is intentionally simple and focuses on foundational AWS services while following Infrastructure as Code principles.

---

## Architecture Diagram

```text
                     ┌─────────────────┐
                     │     User        │
                     └────────┬────────┘
                              │
                              ▼
                 ┌─────────────────────────┐
                 │ S3 Website Endpoint     │
                 │ Static Website Hosting  │
                 └───────────┬─────────────┘
                             │
                             ▼
                ┌──────────────────────────┐
                │      S3 Bucket           │
                │                          │
                │  index.html              │
                │  error.html              │
                └───────────┬──────────────┘
                            │
                            ▼
               ┌────────────────────────────┐
               │ Bucket Policy              │
               │ Public Read Access         │
               └────────────────────────────┘
```

---

## Components

### 1. AWS Provider

Terraform uses the AWS provider to provision resources within the selected AWS region.

Resource:

```hcl
provider "aws"
```

---

### 2. S3 Bucket

Stores website assets.

Resource:

```hcl
aws_s3_bucket
```

Responsibilities:

* Store website files
* Serve content through website endpoint
* Host static assets

---

### 3. Website Configuration

Enables website hosting functionality.

Resource:

```hcl
aws_s3_bucket_website_configuration
```

Configuration:

```text
index.html
error.html
```

---

### 4. Public Access Block

Controls bucket accessibility settings.

Resource:

```hcl
aws_s3_bucket_public_access_block
```

Purpose:

* Permit public website access
* Allow public bucket policy usage

---

### 5. Ownership Controls

Defines ownership of uploaded objects.

Resource:

```hcl
aws_s3_bucket_ownership_controls
```

Setting:

```text
BucketOwnerPreferred
```

---

### 6. Bucket Policy

Allows public website visitors to read objects.

Resource:

```hcl
aws_s3_bucket_policy
```

Permission:

```text
s3:GetObject
```

Applied to:

```text
arn:aws:s3:::bucket-name/*
```

---

### 7. Website Assets

Files uploaded by Terraform:

```text
website/index.html
website/error.html
```

Managed using:

```hcl
aws_s3_object
```

---

## Deployment Flow

```text
Terraform Init
        │
        ▼
Terraform Plan
        │
        ▼
Terraform Apply
        │
        ▼
Create S3 Bucket
        │
        ▼
Enable Website Hosting
        │
        ▼
Configure Ownership
        │
        ▼
Configure Public Access
        │
        ▼
Apply Bucket Policy
        │
        ▼
Upload Website Files
        │
        ▼
Expose Website Endpoint
```

---

## Security Considerations

Current implementation intentionally allows public read access for educational and static hosting purposes.

Allowed:

```text
s3:GetObject
```

Not Allowed:

```text
s3:PutObject
s3:DeleteObject
s3:ListBucket
```

Public users may only retrieve website content.

---

## Cost Considerations

This project is designed to operate within AWS Free Tier limits.

Typical costs:

```text
S3 Storage: Minimal
Requests: Minimal
Bandwidth: Low
```

Expected monthly cost:

```text
$0.00
```

for personal learning and portfolio demonstrations.

---

## Future Architecture

Planned enhancements:

```text
User
 │
 ▼
CloudFront
 │
 ▼
ACM Certificate
 │
 ▼
Route53 Domain
 │
 ▼
S3 Website Bucket

Terraform Remote State
 │
 ├── S3 Backend
 └── DynamoDB Lock Table

GitHub Actions
 │
 ▼
Automated Terraform Deployment
```
