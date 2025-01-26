#!/usr/bin/env bash
set -e

echo "Testing Smart Outreach Setup..."

# Check Docker services
echo "Checking Docker services..."
if ! docker ps | grep -q smart-outreach-redis; then
    echo "Error: Redis container is not running"
    exit 1
fi

if ! docker ps | grep -q smart-outreach-selenium; then
    echo "Error: Selenium container is not running"
    exit 1
fi

# Test Redis connection
echo "Testing Redis connection..."
if ! docker exec smart-outreach-redis redis-cli ping | grep -q "PONG"; then
    echo "Error: Redis is not responding"
    exit 1
fi

# Test Selenium connection
echo "Testing Selenium connection..."
if ! curl -s http://localhost:4444/wd/hub/status | grep -q "ready"; then
    echo "Error: Selenium is not responding"
    exit 1
fi

# Check environment variables
echo "Checking environment variables..."
if [ ! -f ../.env ]; then
    echo "Error: .env file is missing"
    exit 1
fi

# Check required directories
echo "Checking directory structure..."
required_dirs=("backend" "frontend" "scripts" "scripts/sql")
for dir in "${required_dirs[@]}"; do
    if [ ! -d "../$dir" ]; then
        echo "Error: Required directory $dir is missing"
        exit 1
    fi
done

echo "All checks passed! Setup is complete." 