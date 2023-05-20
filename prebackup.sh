#!/bin/bash

# Check if there are any arguments
if [[ $# -eq 0 ]]; then
  echo "No arguments provided."
  exit 1
fi

# Check if the first argument starts with "-"
if [[ $1 == -* ]]; then
  # Populate tags array with all arguments
  tags=("$@")
else
  # Populate tags array with "--ppNULL" followed by all arguments
  tags=("--ppNULL" "$@")
fi

# Initialize path_target array
path_target=()

# Iterate over the tags array and process each tag
for tag in "${tags[@]}"; do
  if [[ $tag == -* ]]; then
    # Add tags starting with "-" to path_target array
    path_target+=("$tag")
  else
    if [[ -f $tag ]]; then
      # Add file path to path_target array
      path_target+=("$(realpath "$tag")")
    elif [[ -d $tag ]]; then
      # Add folder path to path_target array
      path_target+=("$(realpath "$tag")/")
    else
      echo "Error: Invalid tag '$tag'."
      exit 1
    fi
  fi
done

# Iterate over the path_target array and print each element
for path in "${path_target[@]}"; do
  echo -n "$path " # Modified to print in the same line
done

echo # Print a new line at the end

