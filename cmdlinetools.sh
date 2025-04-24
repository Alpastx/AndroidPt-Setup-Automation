#!/bin/bash

temp_file=$(mktemp)

echo -e "[*] Fetching latest cmdline-tools.zip \n "
curl -s https://developer.android.com/studio#cmdline-tools -o "$temp_file"

url=$(grep -oP 'https://dl.google.com/android/repository/commandlinetools-linux-[0-9]+_latest.zip' "$temp_file" | head -n 1)

rm "$temp_file"

if [[ -z "$url" ]]; then
  echo "[!] Failed to fetch the latest cmdline-tools URL."
  exit 1
fi

download_dir="$(pwd)"
filename=$(basename "$url")

curl -L "$url" -o "$download_dir/$filename"

if [[ $? -ne 0 ]]; then
  echo "[!] Failed to download $filename."
  exit 1
fi

echo -e "[✓] Download complete: $download_dir/$filename \n"
