#!/bin/bash

if [ -f "burp.der" ]; then
    echo "burp.der found!"
else
    echo "burp.der not found"
    exit 1
fi

if command -v openssl >/dev/null 2>&1; then
    echo "OpenSSL is installed."
else
    echo "OpenSSL is NOT installed. Installing with yay..."
    yay -S --noconfirm openssl
fi

echo -e "Generating burp.cer from burp.der...\n"
openssl x509 -inform der -in burp.der -out burp.cer

echo -e "Generating hash...\n"
hash=$(openssl x509 -inform PEM -subject_hash_old -in burp.cer | head -1)

echo -e "Converting to Android cert format...\n"
cp burp.cer "$hash.0"

echo -e "Running A10 Emulator...\n"
emulator -avd A10 -writable-system > /dev/null 2>&1 &

echo -e "Waiting for emulator to start...\n"
adb wait-for-device
sleep 10

adb root
sleep 5

echo -e "Disabling AVB verification...\n"
adb shell avbctl disable-verification
adb reboot
echo -e "Waiting for device to reboot...\n"
adb wait-for-device
sleep 10

adb root
sleep 5

echo -e "Pushing cert to emulator...\n"
adb remount
adb push "$hash.0" /system/etc/security/cacerts/
adb shell chmod 644 /system/etc/security/cacerts/"$hash.0"

echo -e "Rebooting to apply changes...\n"
adb reboot
