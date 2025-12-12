#!/bin/bash
set -e


envsubst < /opt/trino/etc/catalog/iceberg.properties.template > /opt/trino/etc/catalog/iceberg.properties

echo "🚀 Starting Unified Analytics Stack"
echo "   - Nessie (Catalog)"
echo "   - Trino (Query Engine)"  
echo "   - dbt (Transformations)"



# Validate required environment variables
if [ -z "$AZURE_STORAGE_ACCOUNT" ] || [ -z "$AZURE_STORAGE_ACCESS_KEY" ]; then
  echo "❌ Error: AZURE_STORAGE_ACCOUNT and AZURE_STORAGE_ACCESS_KEY must be set"
  exit 1
fi

echo "✅ Azure Storage Account: $AZURE_STORAGE_ACCOUNT"

# Start Nessie in background
echo "🔄 Starting Nessie..."
java -jar /opt/nessie.jar &
NESSIE_PID=$!

# Wait for Nessie to start
sleep 10

# Start Trino in background
echo "🔄 Starting Trino..."
/opt/trino/bin/launcher run &
TRINO_PID=$!

# Wait for Trino to start
echo "⏳ Waiting for Trino to initialize..."
sleep 20

# Verify services are running
if ! curl -s http://localhost:19120/api/v2/config >/dev/null; then
  echo "❌ Nessie failed to start"
  exit 1
fi

if ! curl -s http://localhost:8080/v1/info >/dev/null; then
  echo "❌ Trino failed to start"  
  exit 1
fi

echo "✅ All services started successfully!"

# Run dbt transformations
#echo "📊 Running dbt transformations..."
#dbt debug --project-dir /app/dbt-project
#dbt run --project-dir /app/dbt-project

#echo "✅ dbt transformations completed!"

# Keep container alive for interactive use
if [ "$KEEP_ALIVE" = "true" ]; then
  echo "🔒 Container kept alive for debugging (KEEP_ALIVE=true)"
  echo "   Trino: http://localhost:8080"
  echo "   Nessie: http://localhost:19120"
  tail -f /dev/null
else
  echo "⏹️  Stopping services..."
  kill $NESSIE_PID $TRINO_PID
  wait $NESSIE_PID $TRINO_PID 2>/dev/null || true
  echo "✅ All services stopped"
fi