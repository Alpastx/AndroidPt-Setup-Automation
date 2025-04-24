#!/bin/bash
echo -e "Fetching latest Magisk release info... \n"

# Get the latest release info from GitHub API
latest_json=$(curl -s https://api.github.com/repos/topjohnwu/Magisk/releases/latest)

# Extract APK URL
apk_url=$(echo "$latest_json" | grep "browser_download_url" | grep ".apk" | cut -d '"' -f 4)

# Download the APK and save as Magisk.zip
curl -L -o Magisk.zip "$apk_url"

mv Magisk.zip ~/android_sdk/rootAVD/

