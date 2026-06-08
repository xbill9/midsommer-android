use this for skills:

https://github.com/sickn33/antigravity-awesome-skills/tree/main

https://github.com/sickn33/antigravity-awesome-skills/blob/main/skills/game-development/SKILL.md

---

# 🇸🇪 Midsommer Madness Developer Guidelines for Gemini

Welcome! This file contains developer context, architecture notes, and guidelines for working on this project.

## 🛠️ Build and Automation Commands

Use the provided `Makefile` to run, build, and debug this application:

* **Local Web Development**: `make dev` or `make run`
* **Android SDK Setup**: `make setup-sdk`
* **Compile Android App**: `make build-apk`
* **Deploy to Device/Emulator**: `make install-apk`
* **Clean Build Directories**: `make clean`
* **Monitor Android Logs**: `make logcat`

## 📂 Project Architecture

* **Web Assets**: The core game is implemented in vanilla HTML, JS, and CSS:
  * [index.html](file:///home/xbill/midsommer-android/index.html): Entry point and mobile-first touch UI canvas.
  * [game.js](file:///home/xbill/midsommer-android/game.js): Gameplay loop (60Hz fixed timestep), rendering, physics, procedural Web Audio synthesizer, and touchscreen joystick input logic.
  * [index.css](file:///home/xbill/midsommer-android/index.css): Styling, layout, animations, and retro colors.
* **Android Wrapper**: Located in the `app` folder, wrapping the web files inside a full-screen, landscape-locked `WebView`:
  * [MainActivity.kt](file:///home/xbill/midsommer-android/app/src/main/java/com/midsommer/madness/MainActivity.kt): Configures the Android `WebView` settings (Web SQL, local storage, hardware acceleration, DOM storage) and activates Immersive Sticky Full-screen mode.
  * **copyGameAssets** (Gradle task in [app/build.gradle](file:///home/xbill/midsommer-android/app/build.gradle)): Automatically registers at build-time to sync web source files into the Android assets directory (`app/src/main/assets`).

## ⚠️ Key Instructions for Gemini / Antigravity

1. **Asset Modifications**: If you modify `game.js`, `index.html`, or `index.css`, you must run a Gradle build (`make build-apk` or `./gradlew assembleDebug`) to trigger the asset sync so the changes reflect in the Android APK.
2. **Web Audio Compatibility**: The Android `WebView` requires user interaction to initialize the Web Audio API context. Ensure `AudioContext` resumes on first touch/click.
3. **Responsive Canvas**: Keep the target aspect ratio in mind when tweaking layouts. Touch controls should dynamically scale.
