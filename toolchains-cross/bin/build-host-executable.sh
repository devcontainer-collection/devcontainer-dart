#!/bin/bash

set -e

SCRIPT_NAME=$(basename "$0")

trap 'echo "Exit $SCRIPT_NAME"' EXIT
echo "Running $SCRIPT_NAME..."

if [ -f "/.dockerenv" ]; then
  echo "$SCRIPT_NAME: This script is only for use on the host machine, not inside a devcontainer."
  exit 0
fi

echo

# Detect Host OS
OS_NAME="$(uname -s)"
ARCH_NAME="$(uname -m)"

case "$OS_NAME" in
  Darwin)  HOST_OS="macos" ;;
  Linux)   HOST_OS="linux" ;;
  *)       echo "Unsupported OS: $OS_NAME" && exit 1 ;;
esac

case "$ARCH_NAME" in
  x86_64|amd64) HOST_ARCH="x64" ;;
  arm64|aarch64) HOST_ARCH="arm64" ;;
  *)       echo "Unsupported architecture: $ARCH_NAME" && exit 1 ;;
esac

TARGET_PLATFORM="$HOST_OS-$HOST_ARCH"
SCRIPT_PATH=$(cd "$(dirname "$0")"; pwd)
WORKSPACE_PATH=$(cd "$SCRIPT_PATH/../../"; pwd)

# SDK paths
SDK_BASE="$SCRIPT_PATH/../sdks/$TARGET_PLATFORM"
DART="$SDK_BASE/dart-sdk/bin/dart"

# ✅ Local SDK zip cache path
CACHE_DIR="$SCRIPT_PATH/../cache"
mkdir -p "$CACHE_DIR"
ZIP_PATH="$CACHE_DIR/dartsdk-${TARGET_PLATFORM}.zip"
SDK_URL="https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-${TARGET_PLATFORM}-release.zip"

# Download SDK if not exists
if [ ! -f "$DART" ]; then
  echo "[Downloading Dart SDK for $TARGET_PLATFORM...]"
  mkdir -p "$SDK_BASE"
  if [ ! -f "$ZIP_PATH" ]; then
    echo "→ Downloading to $ZIP_PATH"
    curl -L "$SDK_URL" -o "$ZIP_PATH"
  else
    echo "→ Using cached zip: $ZIP_PATH"
  fi
  unzip -q "$ZIP_PATH" -d "$SDK_BASE"
  echo "[Dart SDK installed at $SDK_BASE]"
fi

# Show Dart version
echo "[Dart Version]"
"$DART" --version
echo

# File to compile
FILE_NAME="dart_example"
FILE_EXT="dart"
PROJECT_PATH="$WORKSPACE_PATH/src"
SOURCE_FILE="$PROJECT_PATH/bin/$FILE_NAME.$FILE_EXT"
BUILD_OUTPUT_PATH="$PROJECT_PATH/build/release"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file not found: $SOURCE_FILE"
    exit 1
fi

mkdir -p "$BUILD_OUTPUT_PATH"

echo "[Build Start]"
echo "$SOURCE_FILE"
echo
"$DART" compile exe "$SOURCE_FILE" -o "$BUILD_OUTPUT_PATH/$FILE_NAME-$TARGET_PLATFORM"
echo
echo "[Build Completed]"
echo "$BUILD_OUTPUT_PATH/$FILE_NAME-$TARGET_PLATFORM"
echo

# confirm run the executable
read -p "Run the executable? [y/N] " confirm
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
  echo
  echo "[Running Executable]"
  echo
  "$BUILD_OUTPUT_PATH/$FILE_NAME-$TARGET_PLATFORM"
fi