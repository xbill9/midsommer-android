#!/bin/bash
set -e

# Make sure we are in the project root directory
cd "$(dirname "$0")"

echo "=== Android SDK CLI Setup ==="
SDK_DIR="/home/xbill/android-sdk"
mkdir -p "$SDK_DIR"

if [ ! -d "$SDK_DIR/cmdline-tools/latest" ]; then
    echo "Downloading Android Command-Line Tools..."
    curl -L -o /tmp/cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
    
    echo "Extracting tools..."
    mkdir -p "$SDK_DIR/cmdline-tools"
    unzip -q /tmp/cmdline-tools.zip -d "$SDK_DIR/cmdline-tools"
    mv "$SDK_DIR/cmdline-tools/cmdline-tools" "$SDK_DIR/cmdline-tools/latest"
    rm -f /tmp/cmdline-tools.zip
fi

# Set Java home
export JAVA_HOME="/usr/lib/jvm/java-25-openjdk-amd64"
export PATH="$JAVA_HOME/bin:$PATH"

echo "Installing Android SDK Platform 34 and Build Tools 34.0.0..."
# Accept licenses and install packages
yes | "$SDK_DIR/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$SDK_DIR" "platforms;android-34" "build-tools;34.0.0"

echo "Creating local.properties..."
echo "sdk.dir=$SDK_DIR" > local.properties

echo "=== Compiling APK via Gradle Wrapper ==="
chmod +x gradlew
./gradlew assembleDebug

echo "=== Build Successful! ==="
echo "APK created at: app/build/outputs/apk/debug/app-debug.apk"
