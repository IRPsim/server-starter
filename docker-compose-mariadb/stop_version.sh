#!/bin/bash
if [ -f .environment ]; then
   source .environment
   echo "Stoppe Version: $build_version"
   docker-compose -p "$build_version" down
else
   echo ".environment nicht gefunden. Bitte starten Sie die Anwendung mHv. start_version.sh"
fi

