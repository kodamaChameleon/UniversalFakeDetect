#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 /path/to/test"
  exit 1
fi

BASE_DIR="$1"
OUTPUT_FILE="dataset_paths.py"

# Normalize path (remove trailing slash if any)
BASE_DIR="${BASE_DIR%/}"

{
  echo "DATASET_PATHS = ["

  ls -1 "$BASE_DIR" | while read -r name; do
    cat <<EOF

    dict(
        real_path='${BASE_DIR}/${name}',
        fake_path='${BASE_DIR}/${name}',
        data_mode='wang2020',
        key='${name}'
    ),
EOF
  done

  echo "]"
} > "$OUTPUT_FILE"

echo "Wrote: $OUTPUT_FILE"