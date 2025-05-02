#!/bin/bash

set -e

ECW_DIR="./ECW"

REQUIRED_ITEMS=(
  "apidoc"
  "bin"
  "ecw_jni"
  "ERDAS_ECW_JPEG2000_SDK.pdf"
  "eula.txt"
  "etc"
  "examples"
  "include"
  "lib"
  "redistributable"
  "testdata"
  "third-party"
)

echo "🔍 Validating contents of $ECW_DIR"

for item in "${REQUIRED_ITEMS[@]}"; do
  if [ ! -e "$ECW_DIR/$item" ]; then
    echo "❌ Missing: $item. Make sure you run installer binary inside of ECW directory"
    exit 1
  else
    echo "✅ Found: $item"
  fi
done

echo "🎉 All required files and directories are present."
