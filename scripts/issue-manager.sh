#!/bin/bash

# GitHub Issue Manager for Marine-Q Project
# Usage: ./scripts/issue-manager.sh [next|status|assign <issue-number>|create-issues]

set -e

REPO="JulianDouma/marine-q"
ISSUES_FILE="scripts/issues.json"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if gh CLI is installed
check_gh_cli() {
    if ! command -v gh &> /dev/null; then
        echo -e "${RED}Error: GitHub CLI (gh) is not installed.${NC}"
        echo "Please install it: https://cli.github.com/"
        exit 1
    fi

    # Check if authenticated
    if ! gh auth status &> /dev/null; then
        echo -e "${RED}Error: Not authenticated with GitHub CLI.${NC}"
        echo "Please run: gh auth login"
        exit 1
    fi
}

# Create all GitHub issues
create_issues() {
    echo -e "${BLUE}Creating GitHub issues for Sonata Admin + API Platform integration...${NC}"
    
    # Issue 1: Install and Configure API Platform 4.x
    gh issue create \
        --title "Install and Configure API Platform 4.x" \
        --body "## Objective
Install API Platform 4.x with proper Symfony 7.3 compatibility and create foundation for admin integration.

## Tasks
- [ ] Install API Platform 4.x with Symfony 7.3 compatibility
- [ ] Configure basic API Platform settings  
- [ ] Create initial sample entity with API Platform attributes
- [ ] Add comprehensive tests for API Platform functionality
- [ ] Update CLAUDE.md with API Platform configuration

## Deliverables
- Working API Platform installation with Symfony 7.3
- Sample API resource accessible at \`/api\`
- Integration tests for API endpoints
- Documentation updates

## Acceptance Criteria
- All existing tests pass
- New API endpoint accessible and tested
- Code coverage maintained at ≥80%
- All quality tools pass (PHP CS Fixer, PHPStan, Rector, Deptrac)
- Application remains in working state

## Dependencies
None - This is the foundation issue." \
        --label "enhancement,api-platform" \
        --assignee "@me"

    # Issue 2: Install and Configure Sonata Admin Bundle 4.x  
    gh issue create \
        --title "Install and Configure Sonata Admin Bundle 4.x" \
        --body "## Objective
Install Sonata Admin Bundle 4.x and set up basic admin interface for the sample entity.

## Tasks
- [ ] Install Sonata Admin Bundle 4.x and required dependencies
- [ ] Configure basic Sonata Admin settings and routing
- [ ] Set up admin layout, navigation and theming
- [ ] Create basic admin class for the sample entity from Issue #1
- [ ] Add functional tests for admin interface

## Deliverables
- Working Sonata Admin interface accessible at \`/admin\`
- Basic admin CRUD for sample entity (using standard Doctrine model manager)
- Admin interface functional tests
- Updated documentation

## Acceptance Criteria
- Admin interface loads without errors
- Basic CRUD operations work through standard Doctrine
- All tests pass including new admin tests
- Code coverage maintained at ≥80%
- All quality tools pass

## Dependencies
- Issue #1 must be completed (API Platform installation)" \
        --label "enhancement,sonata-admin" \
        --assignee "@me"

    # Issue 3: Create API Platform Model Manager
    gh issue create \
        --title "Create Custom API Platform Model Manager" \
        --body "## Objective
Implement a custom ModelManager that uses API Platform HTTP calls instead of direct Doctrine ORM operations.

## Tasks
- [ ] Create custom ModelManager class implementing ModelManagerInterface
- [ ] Implement API client service for HTTP operations (GET, POST, PUT, DELETE)
- [ ] Implement all CRUD operations through API calls
- [ ] Add comprehensive unit tests for the model manager
- [ ] Add integration tests for API operations
- [ ] Handle authentication, error scenarios, and edge cases

## Deliverables
- Custom ModelManager class with full API Platform integration
- API client service with proper error handling
- Full test coverage for all CRUD operations
- Proper validation and error handling

## Acceptance Criteria
- ModelManager successfully performs all CRUD operations via API
- Comprehensive error handling for network/API failures
- All existing tests pass plus new model manager tests
- Code coverage maintained at ≥80%
- All quality tools pass

## Dependencies
- Issues #1 and #2 must be completed" \
        --label "enhancement,api-platform,sonata-admin" \
        --assignee "@me"

    # Issue 4: Integrate Model Manager with Sonata Admin
    gh issue create \
        --title "Integrate Custom Model Manager with Sonata Admin" \
        --body "## Objective
Configure Sonata Admin to use the custom API Platform Model Manager instead of the default Doctrine model manager.

## Tasks
- [ ] Configure Sonata Admin to use custom API Platform Model Manager
- [ ] Update admin classes to work with API-driven data
- [ ] Implement proper form handling and validation through API
- [ ] Add functional tests for admin CRUD operations through API
- [ ] Handle edge cases, pagination, and error scenarios
- [ ] Ensure proper user feedback for API errors

## Deliverables
- Admin interface fully integrated with API Platform
- Working CRUD operations through admin interface via API
- Proper error handling and user feedback
- Comprehensive functional test suite

## Acceptance Criteria
- Admin interface performs all operations through API (no direct DB access)
- Form validation works correctly with API responses
- Error messages are user-friendly
- All tests pass including integration tests
- Code coverage maintained at ≥80%
- Performance is acceptable for admin operations

## Dependencies
- Issue #3 must be completed (Custom Model Manager)" \
        --label "enhancement,integration,sonata-admin" \
        --assignee "@me"

    # Issue 5: Add Advanced Admin Features
    gh issue create \
        --title "Add Advanced Admin Features with API Integration" \
        --body "## Objective
Implement advanced Sonata Admin features that work seamlessly with the API Platform backend.

## Tasks
- [ ] Implement list filtering through API query parameters
- [ ] Add batch operations support via API
- [ ] Implement proper pagination for large datasets
- [ ] Add search functionality through API endpoints
- [ ] Create advanced form types and field mappings
- [ ] Optimize performance for large datasets
- [ ] Add caching where appropriate

## Deliverables
- Advanced admin features working through API
- Performance optimizations for large datasets
- Enhanced user experience with filtering and search
- Full test coverage for advanced features

## Acceptance Criteria
- Filtering, search, and pagination work efficiently through API
- Batch operations complete successfully
- Performance is acceptable even with large datasets
- All tests pass including performance tests
- Code coverage maintained at ≥80%
- User experience is smooth and responsive

## Dependencies
- Issue #4 must be completed (Basic integration working)" \
        --label "enhancement,performance,sonata-admin" \
        --assignee "@me"

    # Issue 6: Documentation and Final Polish
    gh issue create \
        --title "Complete Documentation and Final Polish" \
        --body "## Objective
Create comprehensive documentation and finalize the Sonata Admin + API Platform integration.

## Tasks
- [ ] Create comprehensive setup and configuration documentation
- [ ] Add code examples and usage patterns
- [ ] Update CLAUDE.md with complete integration instructions
- [ ] Create troubleshooting guide for common issues
- [ ] Finalize test coverage and ensure all edge cases are covered
- [ ] Code review and refactoring for maintainability
- [ ] Performance review and optimizations

## Deliverables
- Complete documentation in CLAUDE.md
- Code examples and best practices guide
- Troubleshooting documentation
- 100% test coverage where applicable
- All quality checks passing consistently

## Acceptance Criteria
- Documentation is comprehensive and easy to follow
- New developers can set up the integration using the docs
- All tests pass with high coverage
- All quality tools pass without issues
- Code is well-structured and maintainable
- Performance meets requirements

## Dependencies
- Issues #1-5 must be completed" \
        --label "documentation,polish" \
        --assignee "@me"

    echo -e "${GREEN}Successfully created all 6 GitHub issues!${NC}"
}

# Get next issue to work on
get_next_issue() {
    echo -e "${BLUE}Fetching next issue to work on...${NC}"
    
    # Get open issues assigned to current user, ordered by creation
    next_issue=$(gh issue list --assignee "@me" --state open --limit 1 --json number,title,labels)
    
    if [[ "$next_issue" == "[]" ]]; then
        echo -e "${YELLOW}No open issues assigned to you.${NC}"
        return 1
    fi
    
    echo -e "${GREEN}Next issue to work on:${NC}"
    echo "$next_issue" | jq -r '.[] | "Issue #\(.number): \(.title)"'
    echo ""
    echo -e "${BLUE}Labels:${NC} $(echo "$next_issue" | jq -r '.[] | .labels[].name' | tr '\n' ', ' | sed 's/,$//')"
    echo ""
    echo -e "${YELLOW}To start working on this issue, run:${NC}"
    echo "gh issue view $(echo "$next_issue" | jq -r '.[].number')"
}

# Show status of all issues
show_status() {
    echo -e "${BLUE}Issue Status Overview:${NC}"
    echo ""
    
    # Get all issues related to this project
    issues=$(gh issue list --limit 20 --json number,title,state,assignees,labels)
    
    if [[ "$issues" == "[]" ]]; then
        echo -e "${YELLOW}No issues found.${NC}"
        return 1
    fi
    
    echo "$issues" | jq -r '.[] | "Issue #\(.number): \(.title) [\(.state)]"'
}

# Assign issue to current user
assign_issue() {
    local issue_number=$1
    
    if [[ -z "$issue_number" ]]; then
        echo -e "${RED}Error: Issue number required${NC}"
        echo "Usage: $0 assign <issue-number>"
        return 1
    fi
    
    echo -e "${BLUE}Assigning issue #$issue_number to current user...${NC}"
    gh issue edit "$issue_number" --add-assignee "@me"
    echo -e "${GREEN}Issue #$issue_number assigned successfully!${NC}"
}

# Main function
main() {
    check_gh_cli
    
    case "${1:-}" in
        "create-issues")
            create_issues
            ;;
        "next")
            get_next_issue
            ;;
        "status")
            show_status
            ;;
        "assign")
            assign_issue "$2"
            ;;
        *)
            echo "GitHub Issue Manager for Marine-Q Project"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  create-issues    Create all GitHub issues for the project"
            echo "  next            Show the next issue to work on"
            echo "  status          Show status of all issues"
            echo "  assign <num>    Assign issue to current user"
            echo ""
            echo "Examples:"
            echo "  $0 create-issues"
            echo "  $0 next"
            echo "  $0 status"
            echo "  $0 assign 1"
            ;;
    esac
}

main "$@"