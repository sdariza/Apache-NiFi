# Data Engineer Project

A data engineering environment using Apache NiFi, Terraform (AWS/Azure), and Databricks.

## Overview

This project provides:
- A containerized Apache NiFi instance with PostgreSQL driver support.
- Terraform scaffolding to provision cloud infrastructure on AWS or Azure.
- Databricks Terraform provider setup to manage workspaces and jobs.

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. **Configure credentials**: Update the username and password in `docker-compose.yml`:
   ```yaml
   SINGLE_USER_CREDENTIALS_USERNAME: <your-username>
   SINGLE_USER_CREDENTIALS_PASSWORD: <your-password-min-12-characters>
   ```

2. **Start the services**:
   ```bash
   docker-compose up -d
   ```

3. **Access NiFi**: Open your browser and navigate to:
   ```
   https://localhost:8443/nifi
   ```
   
   Note: You may need to accept the self-signed certificate warning.

4. **Login**: Use the credentials you configured in step 1.

## Project Structure

```
.
├── docker-compose.yml                  # Service orchestration (NiFi)
├── Dockerfile                         # Custom NiFi image with PostgreSQL driver
├── DataOps/
│   └── terraform/
│       ├── aws/                       # AWS provider setup
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── azure/                     # Azure provider setup
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       └── databricks/                # Databricks provider setup
│           ├── main.tf
│           └── variables.tf
└── README.md                         # Project documentation
```

## Features

- **Apache NiFi**: Latest version for data flow automation
- **PostgreSQL Support**: Includes JDBC driver (version 42.7.8)
- **Persistent Storage**: Data persists across container restarts
- **Secure Access**: HTTPS enabled on port 8443
- **Terraform (AWS/Azure)**: Ready-to-init provider scaffolding
- **Databricks Provider**: Configure with host/token to manage clusters/jobs

## Volumes

The following volumes ensure data persistence:

- `nifi-conf`: Configuration files
- `nifi-state`: State information
- `nifi-content`: Content repository
- `nifi-flowfile`: FlowFile repository
- `nifi-provenance`: Provenance repository

## Useful Commands

### Start services
```bash
docker-compose up -d
```

### Stop services
```bash
docker-compose down
```

### View logs
```bash
docker-compose logs -f nifi
```

### Rebuild image
```bash
docker-compose up -d --build
```

### List containers
```bash
docker ps -a
```

## Terraform

### AWS
1. Navigate to the AWS folder and initialize:
```bash
cd DataOps/terraform/aws
terraform init
```
2. (Optional) Set region:
```bash
terraform plan -var aws_region=us-east-1
```

### Azure
1. Ensure Azure auth is available (via `az login` or `ARM_*` env vars).
2. Initialize:
```bash
cd DataOps/terraform/azure
terraform init
```
3. (Optional) Specify location/IDs:
```bash
terraform plan -var location=eastus -var subscription_id=<SUB_ID> -var tenant_id=<TENANT_ID>
```

### Databricks
1. Export credentials (recommended):
```bash
export DATABRICKS_HOST=https://<region>.azuredatabricks.net
export DATABRICKS_TOKEN=<PAT_TOKEN>
```
2. Or pass via variables; then initialize:
```bash
cd DataOps/terraform/databricks
terraform init
```

Note: No resources are defined by default. Add modules/resources per cloud as needed.

## Configuration

### Environment Variables

- `NIFI_WEB_HTTPS_PORT`: HTTPS port (default: 8443)
- `SINGLE_USER_CREDENTIALS_USERNAME`: Admin username
- `SINGLE_USER_CREDENTIALS_PASSWORD`: Admin password (minimum 12 characters)

### Custom Dependencies

Additional JDBC drivers or libraries can be added by copying them to `/opt/nifi/nifi-current/lib/` in the Dockerfile.

### Cloud Credentials
- **AWS**: Uses default credential chain (env vars, config files, or `aws sso/login`).
- **Azure**: Uses `az login` or `ARM_*` environment variables.
- **Databricks**: Uses `DATABRICKS_HOST` and `DATABRICKS_TOKEN`.

## Troubleshooting

### Cannot connect to NiFi
- Ensure the container is running: `docker ps`
- Check logs: `docker-compose logs nifi`
- Wait a few minutes after startup for NiFi to fully initialize

### Certificate warnings
- NiFi uses self-signed certificates by default
- It's safe to proceed in development environments

## License

This project uses Apache NiFi, which is licensed under the Apache License 2.0.

## Support

For NiFi documentation, visit: https://nifi.apache.org/docs.html
