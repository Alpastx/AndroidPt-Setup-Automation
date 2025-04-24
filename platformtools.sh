#!/bin/bash
echo -e "[*] Fetching latest platform-tools.zip"
# Define the URL of the latest platform tools
url="https://dl.google.com/android/repository/platform-tools-latest-linux.zip"

# Get current working directory
download_dir="$(pwd)"

# Extract filename from URL
filename=$(basename "$url")

# Download the file using curl
echo "Downloading $filename..."
curl -L "$url" -o "$download_dir/$filename"

# Check if download was successful
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to download Android Platform Tools."
  exit 1
fi

echo "Download complete. File saved as $download_dir/$filename"
