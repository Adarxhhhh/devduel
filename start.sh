#!/bin/bash
# DevDuel - Start All Services
# Usage: ./start.sh [service-name]
# Examples:
#   ./start.sh          # Start all services
#   ./start.sh auth     # Start only auth-service
#   ./start.sh frontend # Start only frontend

set -e

export JAVA_HOME="/opt/homebrew/opt/openjdk@21"
export PATH="$JAVA_HOME/bin:/opt/homebrew/bin:/opt/homebrew/opt/postgresql@17/bin:$PATH"

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PIDS=()

cleanup() {
    echo ""
    echo "Shutting down all services..."
    for pid in "${PIDS[@]}"; do
        kill "$pid" 2>/dev/null || true
    done
    wait 2>/dev/null
    echo "All services stopped."
    exit 0
}
trap cleanup SIGINT SIGTERM

load_env() {
    local env_file="$1"
    if [ -f "$env_file" ]; then
        while IFS='=' read -r key value; do
            # Skip comments and empty lines
            [[ "$key" =~ ^#.*$ ]] && continue
            [[ -z "$key" ]] && continue
            # Remove surrounding quotes from value
            value="${value%\"}"
            value="${value#\"}"
            value="${value%\'}"
            value="${value#\'}"
            export "$key=$value"
        done < "$env_file"
    fi
}

start_service() {
    local name="$1"
    local dir="$PROJECT_DIR/$name"

    echo "Starting $name..."
    load_env "$dir/.env"
    (cd "$dir" && mvn spring-boot:run -q 2>&1 | sed "s/^/[$name] /") &
    PIDS+=($!)
    echo "  $name started (PID: ${PIDS[-1]})"
}

start_frontend() {
    echo "Starting frontend..."
    (cd "$PROJECT_DIR/frontend" && npm run dev 2>&1 | sed "s/^/[frontend] /") &
    PIDS+=($!)
    echo "  frontend started (PID: ${PIDS[-1]})"
}

# Ensure PostgreSQL and Redis are running
echo "=== DevDuel Startup ==="
echo ""

echo "Checking infrastructure..."
brew services start postgresql@17 2>/dev/null || true
brew services start redis 2>/dev/null || true
sleep 1

# Check PostgreSQL is ready
if ! pg_isready -q 2>/dev/null; then
    echo "WARNING: PostgreSQL is not ready. Please start it manually."
fi

# Check Redis is ready
if ! redis-cli ping &>/dev/null; then
    echo "WARNING: Redis is not ready. Please start it manually."
fi

echo "Infrastructure ready."
echo ""

if [ -n "$1" ]; then
    case "$1" in
        auth)       start_service "auth-service" ;;
        challenge)  start_service "challenge-service" ;;
        match)      start_service "match-service" ;;
        leaderboard) start_service "leaderboard-service" ;;
        ai)         start_service "ai-service" ;;
        frontend)   start_frontend ;;
        *)          echo "Unknown service: $1"; exit 1 ;;
    esac
else
    # Start all backend services
    start_service "auth-service"
    sleep 3
    start_service "challenge-service"
    start_service "match-service"
    start_service "leaderboard-service"
    start_service "ai-service"
    sleep 2
    start_frontend

    echo ""
    echo "=== All services starting ==="
    echo "  Auth:        http://localhost:8081/health"
    echo "  Challenge:   http://localhost:8082/health"
    echo "  Match:       http://localhost:8083/health"
    echo "  Leaderboard: http://localhost:8084/health"
    echo "  AI:          http://localhost:8085/health"
    echo "  Frontend:    http://localhost:5173"
    echo ""
    echo "Press Ctrl+C to stop all services"
fi

wait
