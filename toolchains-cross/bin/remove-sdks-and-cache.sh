#!/bin/bash
set -e

echo
echo "WARNING: This will delete all SDKs and cached zip files inside toolchains-cross"
echo "Directories affected:"
echo "  - toolchains-cross/sdks/*"
echo "  - toolchains-cross/cache/*"
echo

read -p "Proceed with cleanup? [y/N] " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Cleanup aborted."
  exit 0
fi

# Get script location
SCRIPT_PATH="$(cd "$(dirname "$0")"; pwd)"
ROOT_PATH="$SCRIPT_PATH/.."

# Clean sdks
SDKS_PATH="$ROOT_PATH/sdks"
if [ -d "$SDKS_PATH" ]; then
  echo "🧹 Cleaning SDKs in: $SDKS_PATH"
  rm -rf "$SDKS_PATH"/*/
else
  echo "SDKs path not found: $SDKS_PATH"
fi

# Clean cache
CACHE_PATH="$ROOT_PATH/cache"
if [ -d "$CACHE_PATH" ]; then
  echo "🧹 Cleaning Cache in: $CACHE_PATH"
  rm -f "$CACHE_PATH"/*
else
  echo "Cache path not found: $CACHE_PATH"
fi

echo
echo "Cleanup complete!"
