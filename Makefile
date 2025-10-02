.PHONY: help start stop restart logs status clean setup backup restore
.DEFAULT_GOAL := help

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

help: ## Show this help message
	@printf "%b\n" "$(BLUE)Mattermost Chat App Management$(NC)"
	@printf "%b\n" ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'

setup: ## Initial setup - copy .env.example to .env
	@if [ ! -f .env ]; then \
		printf "%b\n" "$(YELLOW)Creating .env file from .env.example$(NC)"; \
		cp .env.example .env; \
		printf "%b\n" "$(RED)⚠️  Please edit .env file and set your passwords!$(NC)"; \
	else \
		printf "%b\n" "$(GREEN).env file already exists$(NC)"; \
	fi

start: ## Start all services
	@printf "%b\n" "$(GREEN)Starting Mattermost chat application...$(NC)"
	@docker-compose up -d
	@printf "%b\n" "$(GREEN)✅ Application started! Access it at http://localhost:8065$(NC)"

stop: ## Stop all services
	@printf "%b\n" "$(YELLOW)Stopping Mattermost chat application...$(NC)"
	@docker-compose down
	@printf "%b\n" "$(GREEN)✅ Application stopped$(NC)"

restart: stop start ## Restart all services

logs: ## View logs from all services
	@docker-compose logs -f

logs-app: ## View logs from Mattermost app only
	@docker-compose logs -f mattermost

logs-db: ## View logs from database only
	@docker-compose logs -f postgres

status: ## Show status of all services
	@docker-compose ps

health: ## Check health of all services
	@printf "%b\n" "$(BLUE)Checking service health...$(NC)"
	@docker-compose ps --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}"

update: ## Pull latest images and restart
	@printf "%b\n" "$(YELLOW)Updating Docker images...$(NC)"
	@docker-compose pull
	@docker-compose up -d
	@printf "%b\n" "$(GREEN)✅ Update complete$(NC)"

clean: ## Remove stopped containers and unused images
	@printf "%b\n" "$(YELLOW)Cleaning up Docker resources...$(NC)"
	@docker-compose down
	@docker system prune -f
	@printf "%b\n" "$(GREEN)✅ Cleanup complete$(NC)"

backup: ## Create backup of data volumes
	@printf "%b\n" "$(YELLOW)Creating backup...$(NC)"
	@mkdir -p backups
	@docker run --rm -v chat-app_mattermost_data:/data -v $(PWD)/backups:/backup alpine tar czf /backup/mattermost-data-$(shell date +%Y%m%d-%H%M%S).tar.gz -C /data .
	@docker run --rm -v chat-app_postgres_data:/data -v $(PWD)/backups:/backup alpine tar czf /backup/postgres-data-$(shell date +%Y%m%d-%H%M%S).tar.gz -C /data .
	@printf "%b\n" "$(GREEN)✅ Backup created in backups/ directory$(NC)"

shell-app: ## Open shell in Mattermost container
	@docker-compose exec mattermost /bin/bash

shell-db: ## Open shell in PostgreSQL container
	@docker-compose exec postgres psql -U mmuser -d mattermost

reset: ## ⚠️ DANGER: Remove all data and start fresh
	@printf "%b" "$(RED)⚠️  This will delete ALL data! Are you sure? [y/N]$(NC) "
	@read ans && [ $${ans:-N} = y ]
	@docker-compose down -v
	@docker-compose up -d
	@printf "%b\n" "$(GREEN)✅ Application reset complete$(NC)"
