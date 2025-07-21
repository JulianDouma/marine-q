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

#### Code Quality Commands
```bash
# Run all quality checks (dry-run)
ddev quality

# Run all quality checks and apply fixes
ddev quality dry-run

# Individual tools
ddev cs                 # Check code style (dry-run)
ddev cs fix            # Fix code style
ddev phpstan           # Run static analysis
ddev phpstan baseline  # Generate PHPStan baseline
ddev rector            # Check refactoring suggestions (dry-run)
ddev rector fix        # Apply refactoring
ddev deptrac           # Run architecture analysis

# Using Composer directly
composer quality       # All checks (dry-run)
composer quality:fix   # All fixes
composer cs:dry        # PHP CS Fixer (dry-run)
composer cs            # PHP CS Fixer (fix)
composer phpstan       # PHPStan analysis
composer rector:dry    # Rector (dry-run)
composer rector        # Rector (fix)
composer deptrac       # Deptrac analysis
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

## Code Quality & Standards

### Tools Configured

- **PHP CS Fixer**: Code style enforcement using `@Symfony` and `@PSR12` standards
- **PHPStan**: Static analysis at level 6 with Symfony extension
- **Rector**: Automated code modernization and refactoring (PHP 8.4 ready)
- **Deptrac**: Architecture testing with 3-layer enforcement (Domain/Application/Infrastructure)

### Configuration Files

- `.php-cs-fixer.dist.php`: PHP CS Fixer configuration
- `phpstan.neon.dist`: PHPStan configuration
- `rector.php`: Rector configuration
- `deptrac.yaml`: Architecture rules

### Development Workflow

1. Write your code following Symfony best practices
2. Run `ddev quality` to check for issues
3. Fix issues manually or run `ddev quality dry-run` to apply automated fixes
4. Commit your changes

### Architecture Layers

The project enforces a clean architecture with these layers:

- **Domain**: Business logic, entities (no external dependencies)
- **Application**: Use cases, controllers, commands (can use Domain + Symfony)
- **Infrastructure**: External services, repositories (can use all layers)

## Commit Standards

### Conventional Commits Specification

This project follows the [Conventional Commits v1.0.0-beta.4](https://www.conventionalcommits.org/en/v1.0.0-beta.4/) specification.

#### Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer]
```

#### Required Types
- `feat:` - A new feature (correlates with MINOR in semantic versioning)
- `fix:` - A bug fix (correlates with PATCH in semantic versioning)
- `chore:` - Maintenance tasks, dependency updates
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, missing semicolons, etc.)
- `refactor:` - Code changes that neither fix bugs nor add features
- `perf:` - Performance improvements
- `test:` - Adding or modifying tests
- `build:` - Changes to build process or tools
- `ci:` - Changes to CI/CD configuration

#### Breaking Changes
- Use `BREAKING CHANGE:` in footer or body
- Optionally add `!` after type: `feat!:` or `fix!:`
- Correlates with MAJOR version in semantic versioning

#### Examples
```bash
# Feature commit
feat(auth): add OAuth2 login support

# Bug fix
fix: resolve memory leak in data processing

# Breaking change
feat!: drop support for PHP 8.2

BREAKING CHANGE: minimum PHP version is now 8.3

# Scoped commit
fix(api): handle null values in user preferences

# Simple commit
docs: update installation instructions
```

#### Commit Enforcement
GrumPHP enforces these standards via git hooks. All commits must:
- Follow the conventional format
- Pass all quality checks (CS Fixer, PHPStan, Rector, Deptrac)
- Be properly formatted and linted

## Notes for Future Development

- The project uses Mutagen for file synchronization (performance mode)
- DDEV automatically handles SSL certificates for local development
- Environment variables can be configured in `.env.local` (git-ignored)
- Symfony debug mode is enabled in development
- All code quality tools run in parallel for performance
- PHPStan baseline can be generated to handle existing code issues
- GrumPHP prevents commits that don't meet quality standards

## Code Quality Standards and Tools

### Coding Standards

Symfony follows strict coding standards based on PSR-1, PSR-2, and PSR-4. All code contributions must adhere to these standards.

**Official Resources:**
- [Symfony Coding Standards](https://symfony.com/doc/current/contributing/code/standards.html)
- [Symfony Conventions](https://symfony.com/doc/current/contributing/code/conventions.html)
- [Symfony Best Practices](https://symfony.com/doc/current/best_practices.html)

### Recommended Tools for Code Quality (2024-2025)

#### 1. Code Formatting and Linting

**PHP CS Fixer** - The official Symfony code formatter
- Install: `composer require --dev friendsofphp/php-cs-fixer`
- Configuration file: `.php-cs-fixer.dist.php`

Example configuration:
```php
<?php
$finder = (new PhpCsFixer\Finder())
    ->in(__DIR__)
    ->exclude('var')
    ->exclude('vendor')
;

return (new PhpCsFixer\Config())
    ->setParallelConfig(PhpCsFixer\Runner\Parallel\ParallelConfigFactory::detect())
    ->setRules([
        '@Symfony' => true,
        '@PSR12' => true,
        'array_syntax' => ['syntax' => 'short'],
        'single_quote' => true,
    ])
    ->setFinder($finder)
;
```

Run with: `ddev exec vendor/bin/php-cs-fixer fix --verbose --show-progress=dots`

#### 2. Static Analysis

**PHPStan** (Primary recommendation)
- Install: `composer require --dev phpstan/phpstan phpstan/phpstan-symfony`
- Configuration file: `phpstan.neon`

Example configuration:
```neon
parameters:
    level: 6
    paths:
        - src
    symfony:
        container_xml_path: var/cache/dev/App_KernelDevDebugContainer.xml
includes:
    - vendor/phpstan/phpstan-symfony/extension.neon
```

Run with: `ddev exec vendor/bin/phpstan analyse`

**Psalm** (Optional - for additional coverage)
- Can be used alongside PHPStan for comprehensive analysis
- Particularly strong with Symfony-specific patterns
- XML configuration format

#### 3. Architecture Testing

**Deptrac** - Ensures architectural boundaries
- Install: `composer require --dev qossmic/deptrac`
- Helps maintain clean architecture with three-level testing:
  1. Layer testing (dependencies between layers)
  2. Module integration testing
  3. Class-level dependency rules

Example configuration in `deptrac.yaml`:
```yaml
deptrac:
  paths:
    - ./src
  layers:
    - name: Controller
      collectors:
        - type: classLike
          value: .*Controller.*
    - name: Service
      collectors:
        - type: classLike
          value: .*Service.*
  ruleset:
    Controller:
      - Service
```

#### 4. Testing Frameworks

**PHPUnit** (Standard)
- Pre-configured with Symfony
- Run tests: `ddev exec php bin/phpunit`

**Pest** (Modern alternative)
- Built on top of PHPUnit with expressive syntax
- Install: `composer require --dev pestphp/pest pestphp/pest-plugin-symfony`
- Offers cleaner test syntax and better developer experience

#### 5. Automated Refactoring

**Rector** - Automated code upgrades and refactoring
- Install: `composer require --dev rector/rector`
- Supports PHP 5.3 to 8.4 upgrades
- Configuration file: `rector.php`

Example configuration:
```php
use Rector\Config\RectorConfig;
use Rector\Symfony\Set\SymfonySetList;

return RectorConfig::configure()
    ->withPaths([__DIR__ . '/src'])
    ->withSymfonyContainerXml(__DIR__ . '/var/cache/dev/App_KernelDevDebugContainer.xml')
    ->withSets([
        SymfonySetList::SYMFONY_64,
        SymfonySetList::SYMFONY_CODE_QUALITY,
    ]);
```

### CI/CD Integration

All these tools should be integrated into your CI/CD pipeline:

```yaml
# Example GitHub Actions workflow
- name: PHP CS Fixer
  run: vendor/bin/php-cs-fixer fix --dry-run --diff

- name: PHPStan
  run: vendor/bin/phpstan analyse

- name: Architecture Tests
  run: vendor/bin/deptrac analyse

- name: Unit Tests
  run: vendor/bin/phpunit
```

### Best Practices Summary

1. **Start with PHP CS Fixer** - Ensure consistent code formatting
2. **Use PHPStan at level 6+** - Catch type errors and bugs early
3. **Consider both PHPStan and Psalm** - 90% overlap but 10% unique findings
4. **Implement Deptrac** - Maintain architectural boundaries
5. **Automate everything** - All tools should run in CI/CD
6. **Use Rector carefully** - Review automated refactoring changes
7. **Keep tools updated** - Regular updates for PHP 8.4 compatibility

### DDEV Integration

Run code quality tools in DDEV:
```bash
# Format code
ddev exec vendor/bin/php-cs-fixer fix

# Static analysis
ddev exec vendor/bin/phpstan analyse

# Architecture testing
ddev exec vendor/bin/deptrac analyse

# Run tests
ddev exec php bin/phpunit
```

## Testing Framework

### Test Pyramid Architecture

This project implements a comprehensive testing strategy following the test pyramid pattern to ensure quality and maintainability.

#### Test Suite Structure

```
tests/
├── Unit/           # Fast, isolated unit tests
├── Integration/    # Integration tests with dependencies
├── Application/    # Feature/functional tests  
└── E2E/           # End-to-end browser tests
```

#### Test Types and Guidelines

**Unit Tests** (`tests/Unit/`)
- Test individual classes and methods in isolation
- Mock external dependencies
- Fast execution (< 10ms per test)
- High coverage of business logic
- Example: Testing service classes, entities, value objects

**Integration Tests** (`tests/Integration/`)
- Test interactions between components
- Use real database connections
- Test repository patterns, API integrations
- Medium execution time
- Focus on data flow and component interaction

**Application Tests** (`tests/Application/`)  
- Test complete user workflows
- HTTP request/response testing
- Controller and form testing
- Use Symfony's test client
- Test user journeys and application features

**End-to-End Tests** (`tests/E2E/`)
- Full browser automation with Panther
- Test complete user scenarios
- Cross-browser compatibility
- Slowest execution but highest confidence
- Critical user paths only

### Code Coverage Requirements

**Minimum Coverage: ≥80%**

This project enforces a minimum code coverage threshold of 80%. GrumPHP will **reject commits** that do not meet this requirement.

Coverage is measured across:
- Line coverage (primary metric)  
- Branch coverage (conditional paths)
- Method coverage (callable methods)

Excluded from coverage:
- Configuration files
- Generated code
- Vendor dependencies
- Test bootstrap files

### Testing Commands

#### DDEV Commands
```bash
# Run all tests
ddev test

# Run specific test suites  
ddev test-unit          # Unit tests only
ddev test-integration   # Integration tests only
ddev test-e2e          # E2E tests only

# Parallel testing (faster execution)
ddev test-parallel

# Coverage reporting
ddev coverage           # Text coverage report
ddev coverage --html    # HTML coverage report
```

#### Composer Scripts
```bash
# Test commands
composer test                  # Run all tests
composer test:unit            # Unit tests only
composer test:integration     # Integration tests only  
composer test:application     # Application tests only
composer test:e2e            # E2E tests only

# Parallel and coverage
composer test:parallel        # Run tests in parallel
composer test:coverage       # Generate coverage report
composer test:coverage-html  # HTML coverage report
```

### Parallel Testing

ParaTest is configured for parallel test execution to improve developer experience:

- **Database Isolation**: Each parallel process uses separate SQLite databases
- **Process Safety**: Tests run in isolated processes with unique `TEST_TOKEN`
- **Configurable Workers**: Default 4 processes, adjustable via `PARATEST_PROCESSES`
- **Drop-in Replacement**: No changes needed to existing tests

Example parallel execution:
```bash
# Run with default 4 processes
ddev test-parallel

# Run with custom process count  
PARATEST_PROCESSES=8 ddev test-parallel
```

### Test Configuration

#### PHPUnit Configuration
- **Bootstrap**: `tests/bootstrap.php`
- **Test Database**: SQLite with per-process isolation  
- **Extensions**: 
  - DAMA Doctrine Test Bundle (transaction management)
  - Symfony Panther (browser testing)
- **Coverage**: Clover XML and HTML reports

#### Database Testing
- **Isolation**: Each test runs in database transaction (auto-rollback)
- **Parallel Safe**: Unique database files per parallel worker
- **Performance**: SQLite for speed, MariaDB schema compatibility

### Quality Assurance

#### Pre-commit Validation
GrumPHP validates before each commit:
1. All quality tools pass (CS Fixer, PHPStan, Rector, Deptrac)
2. Test suite passes completely
3. **Code coverage ≥80%** (enforced)
4. Commit message follows conventional format

#### Coverage Enforcement
- Coverage reports generated automatically during GrumPHP validation
- Failed coverage checks prevent commits
- Coverage reports available in `build/` directory:
  - `build/logs/clover.xml` - Machine readable format
  - `build/coverage/` - Human readable HTML reports

### Development Workflow

1. **Write Tests First** (TDD recommended)
   - Start with failing unit tests
   - Implement minimum code to pass
   - Refactor with test safety net

2. **Run Tests Frequently**
   ```bash
   # Quick feedback loop
   ddev test-unit
   
   # Full validation before commit
   ddev test && ddev coverage
   ```

3. **Maintain Coverage**
   - Aim for >90% coverage on new code
   - Monitor coverage reports regularly
   - Add tests for uncovered branches

4. **Use Parallel Testing**
   - Default for CI/CD pipelines
   - Optional for local development
   - Significant time savings on large test suites

### Best Practices

- **Unit tests**: Fast, focused, isolated
- **Integration tests**: Realistic data and dependencies  
- **Application tests**: User perspective, complete features
- **E2E tests**: Critical paths only, maintain carefully
- **Coverage**: Quality over quantity - test meaningful scenarios
- **Parallel**: Enable for CI, optional for local development
- **Performance**: Keep test execution under 30 seconds for quick feedback

The testing infrastructure is designed to be **drop-in** and transparent to developers while ensuring high code quality and maintainability.