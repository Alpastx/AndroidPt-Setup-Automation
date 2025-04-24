
# Android SDK and Emulator Setup Guide

This setup script automates the installation and configuration of the Android SDK, command-line tools, platform tools, AVDs (Android Virtual Devices), and Magisk. It's tailored for Linux systems and assumes `zsh` and `yay` (for Arch-based systems) are installed.

---

## 📁 Script Structure

The setup involves the following Bash scripts:

- `setup.sh` – The main installer and configurator
- `cmdlinetools.sh` – Downloads the latest `cmdline-tools`
- `platformtools.sh` – Downloads the latest `platform-tools`
- `Magisk.sh` – Fetches the latest Magisk release APK

---

## 🔧 `setup.sh` (Main Script)

This script orchestrates the setup process:

1. **Fetch SDK components**  
   Runs `cmdlinetools.sh` and `platformtools.sh` to download Android tools.

2. **Unzip downloaded packages**  
   Unzips `commandlinetools` and `platform-tools` archives.

3. **Organize SDK directory structure**
   ```
   android_sdk/
   ├── cmdline-tools/latest/
   ├── platform-tools/
   └── platforms/
   ```

4. **Move SDK to Home Directory**
   Moves the structured `android_sdk` folder to `~/`.

5. **Clone rootAVD Repo**
   Downloads `rootAVD` into the SDK folder:
   ```
   ~/android_sdk/rootAVD/
   ```

6. **Download Magisk**
   Calls `Magisk.sh` to fetch the latest Magisk APK and move it to `rootAVD`.

7. **Environment Variables & Aliases**
   Appends paths and aliases to `~/.zshrc`:
   ```bash
   export PATH="$HOME/android_sdk/cmdline-tools/latest/bin:$PATH"
   export PATH="$HOME/android_sdk/platform-tools:$PATH"
   export PATH="$HOME/android_sdk/emulator:$PATH"
   export ANDROID_HOME=$HOME/android_sdk

   alias A10='emulator -avd A10'
   alias A14PR='emulator -avd A14PR'
   ```

8. **JDK Installation**
   Installs Java Development Kit using `yay`.

9. **Install System Images**
   Uses `sdkmanager` to install:
   - Android 10 (API 29) Google APIs x86
   - Android 14 (API 34) Google APIs Play Store x86_64

10. **Create AVDs**
    - `A10` for Android 10
    - `A14PR` for Android 14 Preview/Release

11. **Fix AVD Config Paths**
    Creates a symlink to make AVD configs discoverable:
    ```bash
    ln -sf ~/.config/.android ~/.android
    ```

---

## 📥 `cmdlinetools.sh`

- Scrapes Android Studio's download page for the latest `commandlinetools-linux-*.zip`
- Downloads it to the current working directory

---

## 📥 `platformtools.sh`

- Downloads the latest `platform-tools-latest-linux.zip` from Google's repository

---

## 📲 `Magisk.sh`

- Uses GitHub API to fetch the latest Magisk release
- Extracts and downloads the `.apk`, saves as `Magisk.zip`
- Moves it to `~/android_sdk/rootAVD/`

---

## ✅ Final Output

At the end of the process, your environment will be ready to:

- Use Android CLI tools
- Launch Android emulators via `A10` and `A14PR` aliases
- Work with rooted AVDs using Magisk
