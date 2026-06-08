# Midsommer Madness - Build and Development Automation Makefile
# Swedish-themed retro arcade game and Android app.

# Default JAVA_HOME pointing to the JDK 25 path used in build_apk.sh
JAVA_HOME ?= /usr/lib/jvm/java-25-openjdk-amd64
export JAVA_HOME
export PATH := $(JAVA_HOME)/bin:$(PATH)

.PHONY: help dev run setup-sdk build-apk install-apk clean logcat

# Default target: show help
help:
	@echo "========================================================================"
	@echo "🇸🇪  Midsommer Madness Build & Development Controls  🇸🇪"
	@echo "========================================================================"
	@echo "Available commands:"
	@echo "  make dev          - Start the local web server for browser play"
	@echo "  make setup-sdk    - Download/configure Android SDK & cmdline-tools"
	@echo "  make build-apk    - Compile the Android App and build Debug APK"
	@echo "  make install-apk  - Install the compiled debug APK on a connected device/emulator"
	@echo "  make clean        - Clean Gradle build outputs and temporary caches"
	@echo "  make logcat       - Monitor application logs from connected Android device"
	@echo "========================================================================"

# Development server
dev: run

run:
	npm run dev

# Android SDK & Environment Setup
setup-sdk:
	@echo "Running Android SDK CLI setup script..."
	chmod +x build_apk.sh
	./build_apk.sh

# Build debug APK
build-apk:
	@echo "Building Debug APK..."
	@if [ ! -f local.properties ]; then \
		echo "local.properties not found. Setting up SDK first..."; \
		$(MAKE) setup-sdk; \
	else \
		chmod +x gradlew; \
		./gradlew assembleDebug; \
	fi

# Install debug APK to device
install-apk:
	@echo "Installing Debug APK to connected device/emulator..."
	chmod +x gradlew
	./gradlew installDebug

# Clean the workspace
clean:
	@echo "Cleaning Android project build directories..."
	chmod +x gradlew
	./gradlew clean
	@rm -rf app/build build

# Logcat monitoring for debugging
logcat:
	adb logcat *:S com.midsommer.madness:V WebView:V chromium:V
