# Mattermost Chat Application

[![Docker Compose](https://img.shields.io/badge/docker--compose-v2.0%2B-blue?logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Mattermost Team Edition](https://img.shields.io/badge/Mattermost-7.0-orange?logo=mattermost&logoColor=white)](https://mattermost.com/download/)
[![Docker Pulls](https://img.shields.io/docker/pulls/mattermost/mattermost-team-edition?logo=docker&logoColor=white)](https://hub.docker.com/r/mattermost/mattermost-team-edition)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![License: JIN](https://img.shields.io/badge/License-JIN-green.svg?logo=opensource)](./LICENSE)

> ⚙️ A full-featured Mattermost chat application, powered by Docker Compose and PostgreSQL, with persistent storage and isolated networking.

This Docker Compose setup provides a complete Mattermost chat application with PostgreSQL database, featuring environment-based configuration, health checks, and easy management tools.

## 🚀 What's Included

- **Mattermost Team Edition**: Open-source chat and collaboration platform
- **PostgreSQL 15**: Database for storing chat data with health checks
- **Environment Variables**: Secure configuration management
- **Health Checks**: Automatic service monitoring
- **Makefile**: Easy management commands
- **Production Ready**: Additional production configuration available

## ⚡ Quick Start

### Method 1: Using Make (Recommended)
```bash
# Initial setup
make setup
# Edit .env file with your secure passwords
nano .env
# Start the application
make start
```

### Method 2: Manual Setup
1. **Configure environment:**
   ```bash
   cp .env.example .env
   # Edit .env and set secure passwords
   nano .env
   ```

2. **Start the application:**
   ```bash
   docker-compose up -d
   ```

3. **Access the chat app:**
   Open your browser and go to: http://localhost:8065

4. **First-time setup:**
   - Create your admin account when prompted
   - Set up your team and invite users
   - Start chatting!

## 🛠️ Management Commands

### Using Make (Recommended)
```bash
make help          # Show all available commands
make start         # Start all services
make stop          # Stop all services
make restart       # Restart all services
make logs          # View logs from all services
make logs-app      # View logs from Mattermost only
make logs-db       # View logs from database only
make status        # Show service status
make health        # Check service health
make update        # Update images and restart
make backup        # Create backup of data
make clean         # Clean up Docker resources
make shell-app     # Open shell in Mattermost container
make shell-db      # Open database shell
make reset         # ⚠️ Reset all data (destructive)
```

### Using Docker Compose Directly
```bash
docker-compose up -d        # Start services
docker-compose down         # Stop services
docker-compose logs -f      # View logs
docker-compose restart      # Restart services
docker-compose pull && docker-compose up -d  # Update
```

## Data Persistence

All data is stored in Docker volumes:
- Chat messages and files
- User accounts and settings
- Database data
- Configuration files

Data will persist even if you stop and restart the containers.

## Customization

You can modify the `docker-compose.yml` file to:
- Change the port (default: 8065)
- Update environment variables
- Add additional services
- Configure SSL/TLS

## Troubleshooting

- **Port already in use:** Change the port mapping from `8065:8065` to `<new-port>:8065`
- **Database connection issues:** Wait a few moments for PostgreSQL to fully start
- **Can't access the app:** Make sure no firewall is blocking port 8065

## 🌐 Production Deployment

For production deployment, use the production Docker Compose file:

```bash
# Copy and edit environment for production
cp .env.example .env.prod
nano .env.prod

# Start with production configuration
docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d
```

### Production Features:
- 🔒 Enhanced security settings
- 🌐 Nginx reverse proxy with SSL support
- 📊 Improved logging and monitoring
- 🛑 Security hardening (no-new-privileges, non-root user)
- 🔐 SSL/TLS ready configuration

## 🔒 Security Notes

### Development (default setup):
- Uses example passwords (change immediately!)
- Intended for local development/testing only
- Developer mode enabled
- Less restrictive security settings

### Production recommendations:
- ✅ Change all default passwords
- ✅ Use `docker-compose.prod.yml`
- ✅ Configure SSL/TLS certificates
- ✅ Set up proper authentication (LDAP/SAML/OAuth)
- ✅ Review and harden security settings
- ✅ Enable proper logging and monitoring
- ✅ Regular backups (`make backup`)
- ✅ Keep images updated (`make update`)

## 🔧 Advanced Configuration

### Environment Variables
All configuration is done via `.env` file. Key variables:

- `POSTGRES_PASSWORD`: Database password (⚠️ required)
- `SITE_URL`: Your domain (for production)
- `MATTERMOST_PORT`: Port to expose (default: 8065)
- `POSTGRES_VERSION`: PostgreSQL version (default: 15-alpine)
- `MATTERMOST_VERSION`: Mattermost version (default: latest)

### File Structure
```
chat-app/
├── .env.example          # Environment template
├── .env                   # Your environment (created by make setup)
├── .gitignore             # Git ignore file
├── docker-compose.yml     # Development configuration
├── docker-compose.prod.yml # Production configuration
├── Makefile              # Management commands
└── README.md             # This file
```
