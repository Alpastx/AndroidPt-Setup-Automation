#!/bin/bash
echo -e "[*] Fetching cmdline-tools & platform-tools\n"

bash cmdlinetools.sh
bash platformtools.sh

echo -e "[*] Unzipping cmdline-tools & platform-tools\n"

# Unzip SDK tools
unzip commandlinetools* && unzip platform-tools* 

echo -e "[*] Organising Dirstruct\n"

# Organize SDK directories
mkdir android_sdk && mv cmdline-tools android_sdk && mv platform-tools android_sdk
mkdir -p android_sdk/cmdline-tools/latest
mkdir -p android_sdk/platforms
mv android_sdk/cmdline-tools/* android_sdk/cmdline-tools/latest/ 2>/dev/null

echo -e "[*] Moving files to home dir \n"
mv android_sdk ~/

# Clone rootAVD repo
git clone https://gitlab.com/newbit/rootAVD.git ~/android_sdk/rootAVD

echo -e "[*] Fetching latets Magisk\n"

bash Magisk.sh

# Add environment variables and aliases to .zshrc
echo 'export PATH="$HOME/android_sdk/cmdline-tools/latest/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="$HOME/android_sdk/platform-tools:$PATH"' >> ~/.zshrc
echo 'export PATH="$HOME/android_sdk/emulator:$PATH"' >> ~/.zshrc
echo 'export ANDROID_HOME=$HOME/android_sdk' >> ~/.zshrc
echo "alias A10='emulator -avd A10 -writable-system'" >> ~/.zshrc
echo "alias A14PR='emulator -avd A14PR'" >> ~/.zshrc

# Source .zshrc
source ~/.zshrc

# Install JDK
yay -S --noconfirm jdk

# Install system images
sdkmanager --install "system-images;android-29;google_apis;x86"
sdkmanager --install "system-images;android-34;google_apis_playstore;x86_64"

# Create AVDs
avdmanager create avd -n "A10" -k "system-images;android-29;google_apis;x86" --force
avdmanager create avd -n "A14PR" -k "system-images;android-34;google_apis_playstore;x86_64" --force

# Symlink for emulator to locate AVD configs
ln -sf ~/.config/.android ~/.android

echo "✅ Android SDK setup complete!"

echo -e "[*] Installing some tools like pipx, frida, objection\n"
yay -S --noconfirm python-pipx
pipx install frida-tools objection frida apkleaks

echo -e "[*] list of Avds \n"

avdmanager list avd

echo -e "[*] Settings up HWKeys for A10 and A14 \n"

bash HWKeys.sh A10
Bash HWKeys.sh A14PR