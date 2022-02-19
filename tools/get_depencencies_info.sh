#!/usr/bin/env bash
set -e

parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
echo $parent_path;
dart run tools-project/lib/main.dart dependencies_info --work-directory "$parent_path/../"