#!/bin/bash
set -e

echo "[startup.sh] Running: dart pub get"
cd /workspace/src/
dart pub get

