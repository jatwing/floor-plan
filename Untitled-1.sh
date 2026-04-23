#!/bin/bash

# ===== CONFIG =====
SOURCE_ROOT="/path/to/folder1"
DEST_ROOT="/path/to/folder2"

SOURCE_SUBFOLDERS=(
  "A"
  "B"
)
# ==================

# ---- Check source root ----
if [ ! -d "$SOURCE_ROOT" ]; then
  echo "ERROR: Source root does not exist: $SOURCE_ROOT"
  exit 1
fi

# ---- Check subfolders ----
for sub in "${SOURCE_SUBFOLDERS[@]}"; do
  if [ ! -d "$SOURCE_ROOT/$sub" ]; then
    echo "ERROR: Missing source folder: $SOURCE_ROOT/$sub"
    exit 1
  fi
done

# ---- Check destination root ----
if [ ! -d "$DEST_ROOT" ]; then
  echo "ERROR: Destination root does not exist: $DEST_ROOT"
  exit 1
fi

echo "All checks passed. Starting copy with conflict protection..."
echo "------------------------------------------------------------"

# ---- Copy with conflict skip ----
for sub in "${SOURCE_SUBFOLDERS[@]}"; do
  echo "Copying folder: $sub"

  rsync -av \
    --ignore-existing \
    --itemize-changes \
    --exclude=".DS_Store" \
    "$SOURCE_ROOT/$sub/" \
    "$DEST_ROOT/$sub/"

done

echo "------------------------------------------------------------"
echo "Copy finished. Existing files were skipped (not overwritten)."