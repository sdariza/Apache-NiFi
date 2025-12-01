# Data Engineer Project

A data engineering environment using Apache NiFi for data flow management and processing.

## Overview

This project provides a containerized Apache NiFi instance with PostgreSQL driver support, ideal for building data pipelines and ETL workflows.

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
├── docker-compose.yml    # Service orchestration
├── Dockerfile           # Custom NiFi image with PostgreSQL driver
└── README.md           # Project documentation
```

## Features

- **Apache NiFi**: Latest version for data flow automation
- **PostgreSQL Support**: Includes JDBC driver (version 42.7.8)
- **Persistent Storage**: Data persists across container restarts
- **Secure Access**: HTTPS enabled on port 8443

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

## Configuration

### Environment Variables

- `NIFI_WEB_HTTPS_PORT`: HTTPS port (default: 8443)
- `SINGLE_USER_CREDENTIALS_USERNAME`: Admin username
- `SINGLE_USER_CREDENTIALS_PASSWORD`: Admin password (minimum 12 characters)

### Custom Dependencies

Additional JDBC drivers or libraries can be added by copying them to `/opt/nifi/nifi-current/lib/` in the Dockerfile.

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
