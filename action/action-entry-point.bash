#!/bin/bash
set -euo pipefail

files=()

while read -r file; do
	files+=("$file")
done < <(jq -r '.[]' <<< "$*")

expand-emoji "${files[@]}"
