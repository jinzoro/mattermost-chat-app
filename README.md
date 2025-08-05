# Mattermost Chat Application

This Docker Compose setup provides a complete Mattermost chat application with PostgreSQL database.

## What's Included

- **Mattermost Team Edition**: Open-source chat and collaboration platform
- **PostgreSQL**: Database for storing chat data
- **Persistent volumes**: Data persists between container restarts
- **Networking**: Isolated network for secure communication between services

## Quick Start

1. **Start the application:**
   ```bash
   docker-compose up -d
   ```

2. **Access the chat app:**
   Open your browser and go to: http://localhost:8065

3. **First-time setup:**
   - Create your admin account when prompted
   - Set up your team and invite users
   - Start chatting!

## Management Commands

- **Start services:** `docker-compose up -d`
- **Stop services:** `docker-compose down`
- **View logs:** `docker-compose logs -f`
- **Restart services:** `docker-compose restart`
- **Update images:** `docker-compose pull && docker-compose up -d`

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

## Security Notes

This setup uses default passwords and is intended for local development/testing. For production use:
- Change all default passwords
- Configure SSL/TLS
- Set up proper authentication
- Review security settings
