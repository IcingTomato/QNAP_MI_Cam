#!/bin/bash

# Set the base directory where random directories are located
base_directory="./"

# Calculate the date threshold for deletion (3 months ago)
date_threshold=$(date --date='-3 months' +'%Y%m%d00')

echo "Before $date_threshold will be deleted!"

# Find all random directories and process them
find "$base_directory" -maxdepth 1 -type d -name '[0-9a-f]*' | while read -r dir; do
  # Change directory to the random directory
  cd "$dir" || continue  # Skip if directory change fails
  echo "Entry $dir."

  # Find and delete directories older than the threshold
  find . -maxdepth 1 -type d -name '??????????' | while read -r subdir; do
    if [[ "$(basename "$subdir")" -lt "$date_threshold" ]]; then
      echo "Deleting directory: $subdir"
      rm -rf "$subdir"  # Remove the directory recursively
    fi
  done

  # Change back to the base directory
  cd ..
done
