#!/bin/bash

# Coverage check script for GrumPHP
# Generates coverage and checks threshold

set -e

CLOVER_FILE="build/logs/clover.xml"
THRESHOLD=${1:-80}

# Create directories if they don't exist
mkdir -p build/logs

# Run tests with coverage (only if not already generated)
if [ ! -f "$CLOVER_FILE" ] || [ "$FORCE_COVERAGE" = "true" ]; then
    echo "Generating code coverage..."
    XDEBUG_MODE=coverage php bin/phpunit --coverage-clover="$CLOVER_FILE" --quiet
fi

# Check if clover file exists
if [ ! -f "$CLOVER_FILE" ]; then
    echo "Coverage file not found: $CLOVER_FILE"
    exit 1
fi

# Check coverage threshold
echo "Checking coverage threshold (>=${THRESHOLD}%)..."
vendor/bin/coverage-check "$CLOVER_FILE" "$THRESHOLD"

if [ $? -eq 0 ]; then
    echo "✅ Coverage check passed!"
else
    echo "❌ Coverage check failed! Minimum required: ${THRESHOLD}%"
    exit 1
fi