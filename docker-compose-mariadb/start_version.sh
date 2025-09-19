#!/bin/bash
# Check for version param
. ./set_env.sh

echo "Starte Version: $build_version" 
echo "Freigabe Backend auf Port $backend_port"
echo "Freigabe Frontend auf Port $apache_port"
echo "Freigabe JMX des Backends auf Port $backend_jmx_port"

docker compose  -p "$build_version" up -d
