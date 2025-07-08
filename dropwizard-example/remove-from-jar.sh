#!/bin/bash

# Check for correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <jar-file> <file-to-remove>"
    exit 1
fi

jar_file="$1"
file_to_remove="$2"

# Check if JAR file exists
if [ ! -f "$jar_file" ]; then
    echo "Error: JAR file $jar_file not found"
    exit 1
fi

# Function to check if file exists in JAR
check_file_exists() {
    if command -v zipinfo &> /dev/null; then
        zipinfo -1 "$jar_file" | grep -qxF "$file_to_remove"
    else
        jar tf "$jar_file" | grep -qxF "$file_to_remove"
    fi
}

# Check if target file exists in JAR
if ! check_file_exists; then
    echo "Error: File $file_to_remove not found in $jar_file"
    exit 1
fi

# Warning about signatures
echo "WARNING: Modifying JAR files may invalidate digital signatures!"
echo "Proceeding in 3 seconds..."
sleep 3

# Remove using zip if available
if command -v zip &> /dev/null; then
    echo "Removing using zip..."
    zip -d "$jar_file" "$file_to_remove"
else
    echo "Removing using jar..."
    temp_dir=$(mktemp -d)
    trap 'rm -rf "$temp_dir"' EXIT

    cp "$jar_file" "$temp_dir/" || exit 1
    cd "$temp_dir" || exit 1

    jar xf "$(basename "$jar_file")" || exit 1
    rm -f "$(basename "$jar_file")" || exit 1
    rm -f "$file_to_remove" || exit 1

    jar cf "$(basename "$jar_file")" * || exit 1
    cd - >/dev/null || exit 1
    mv "$temp_dir/$(basename "$jar_file")" "$jar_file" || exit 1
fi

# Verify removal
if check_file_exists; then
    echo "Error: Failed to remove $file_to_remove from $jar_file"
    exit 1
else
    echo "Successfully removed $file_to_remove from $jar_file"
fi

