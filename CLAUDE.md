# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Marine-Q is a Symfony 7.3 web application running on PHP 8.4 with MariaDB database, managed through DDEV.

## Repository Status

- **Git Remote**: `git@github.com:JulianDouma/marine-q.git`
- **Default Branch**: main
- **Framework**: Symfony 7.3.1
- **PHP Version**: 8.4
- **Database**: MariaDB 10.11
- **Development Environment**: DDEV

## Development Setup

### Prerequisites
- DDEV installed and running
- Docker/Colima configured

### Quick Start
```bash
# Start the development environment
ddev start

# Access the application
# URL: https://marine-q.ddev.site
```

### Common Commands

#### DDEV Commands
```bash
ddev start          # Start containers
ddev stop           # Stop containers
ddev restart        # Restart containers
ddev describe       # Show project info
ddev ssh            # SSH into web container
ddev logs           # View container logs
```

#### Symfony Commands
```bash
ddev exec php bin/console           # Run Symfony console
ddev composer install                # Install dependencies
ddev composer require <package>      # Add new package
ddev exec php bin/console make:controller  # Create controller
ddev exec php bin/console cache:clear      # Clear cache
```

#### Database Commands
```bash
ddev mysql          # Access MySQL CLI
# Database credentials:
# - User: db
# - Password: db
# - Database: db
# - Root password: root
```

## Claude CLI Configuration

The repository includes Claude CLI settings that allow `find` and `ls` bash commands. This configuration is stored in `.claude/settings.local.json`.

## Project Structure

```
.
├── .ddev/              # DDEV configuration
├── bin/                # Symfony console and other executables
├── config/             # Application configuration
├── public/             # Web root (index.php)
├── src/                # Application source code
├── var/                # Generated files (cache, logs)
├── vendor/             # Composer dependencies
├── .env                # Environment variables
├── composer.json       # PHP dependencies
└── symfony.lock        # Symfony recipe versions
```

## Environment Details

- **Local URL**: https://marine-q.ddev.site
- **Mailpit**: https://marine-q.ddev.site:8026
- **Web Server**: nginx-fpm
- **Node.js**: v22 (available in container)
- **Composer**: v2

## Notes for Future Development

- The project uses Mutagen for file synchronization (performance mode)
- DDEV automatically handles SSL certificates for local development
- Environment variables can be configured in `.env.local` (git-ignored)
- Symfony debug mode is enabled in development