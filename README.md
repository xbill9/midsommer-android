# Midsommer Madness 🇸🇪

Midsommer Madness is a Swedish-themed action retro arcade game inspired by *Redneck Rampage* and the Swedish Midsummer holiday. 

Help Sven race against the solar timer to reach the Maypole (*midsommarstång*) before sundown! If you fail, the solstice is lost, you trigger a meltdown, and you are sacrificed to the Wicker Man.

---

## 📸 Screen Gallery

| Title Screen | Game Over Screen | Victory Screen |
| :---: | :---: | :---: |
| ![Title Screen](midsommer_madness_title.png) | ![Meltdown Screen](midsommer_meltdown.png) | ![Victory Screen](midsommer_victory.png) |

---

## 🎮 Level Sequence

The game features ten distinct thematic levels:
1. **IKEA Warehouse:** Battle crowded, flatpack-carrying shoppers who throw box projectiles at you.
2. **Systembolaget:** The state-owned liquor shop crowded with drunk Swedes stumbling and lobbing green beer bottles.
3. **Lördagsgodis:** Sugar rush Saturday! Dodge hyperactive, strung-out Swedish kids throwing sweet candy projectiles.
4. **The Swedish Pub:** Sing along with Frank Zappa fans singing "Bobby Brown" (shouting and firing glowing letters `B`, `O`, `B`, `B`, `Y`).
5. **Volvo Highway:** A survival lane-crossing level where boxy blue Volvo station wagons zoom across lanes at high speeds.
6. **Dalarna Forest:** Deep green woods where giant red wooden Dalarna Horses charge at Sven in sudden dash-bursts.
7. **Allemansrätten:** Swedish right to roam! Harvest wild cloudberries while dodging aggressive elk charging and stomping.
8. **Kvinnafängelset:** Escape the Swedish women's prison! Dodging strict guards throwing heavy metal handcuffs.
9. **Avicii Rave:** A dark neon rave under strobe lights. Dance through ravers wearing shades who throw glowing glowsticks.
10. **ABBA Disco:** The final level under glowing purple lights. Chrome ABBA Bots fire multi-directional pink disco laser spreads. Reach the Maypole in the center to save Midsummer!

---

## 🛠️ Combat & Mechanics

- **Fixed Timestep Loop:** Game logic updates at a solid 60Hz timestep, while rendering runs at the browser's maximum frame rate (interpolated) to ensure smooth gameplay.
- **Hockey Stick (Melee):** Left-click swings the stick in front of Sven towards the cursor, damaging and knocking back enemies. Alternatively, press **H** as a keyboard shortcut.
- **Surströmming Bomb (Ranged):** Right-click or Space throws a canned fermented herring that explodes, creating a lingering toxic green gas cloud that damages all enemies inside.
- **Swedish Power-Ups:**
  - **Köttbullar (Meatballs):** Restores 25 energy.
  - **Knäckebröd (Crispbread):** Grants a 4-second speed boost (+50% speed) and a yellow dotted forcefield shield (blocks 80% of damage).
- **Procedural Synthesizer (Web Audio API):** All game music and SFX are procedurally synthesized in real-time, adjusting BPM, scales, and motifs depending on the level (e.g. happy chiptunes, acoustic folk, heavy metal, EDM, and disco).
- **Screen Shake:** Dynamic impact feedback on hits and stomps.

---

## 🚀 How to Play Locally

1. Start the local server:
   ```bash
   make dev
   ```
   *Alternatively, run `npm run dev`.*
2. Open your browser and navigate to the port displayed in the console output.

---

## ⌨️ Controls

- **W, A, S, D** or **Arrow Keys** — Move Sven
- **Mouse Movement** — Aim
- **Left Click** or **H** — Swing Hockey Stick (Melee)
- **Right Click** or **Space** — Throw Surströmming Bomb (Ranged)

---

## 📱 Android App Refactoring & CLI Build

This project has been refactored into a fully buildable Android Application wrapped in a native WebView. It includes:
* **Mobile Touch Controls**: Left-side Virtual Joystick for movement and Sven direction aiming, plus right-side action buttons for melee (🏒) and ranged (🐟) attacks.
* **Aspect-Ratio Scaling**: Auto-scales the game canvas to fit mobile displays while keeping the target 800x500 layout.
* **Full-Screen Immersive Mode**: Uses native Android immersive sticky views to hide the system status/navigation bars.
* **Automated Asset Sync**: A custom Gradle task copies game assets automatically on build.

### Android Project Structure
- [MainActivity.kt](file:///home/xbill/midsommer-android/app/src/main/java/com/midsommer/madness/MainActivity.kt): Native Activity launcher configuring WebView capabilities and full-screen flags.
- [AndroidManifest.xml](file:///home/xbill/midsommer-android/app/src/main/AndroidManifest.xml): Controls screen orientation (landscape lock) and app configurations.
- [build.gradle](file:///home/xbill/midsommer-android/app/build.gradle): Declares SDK compile versions, dependencies, and registers the `copyGameAssets` task.

### 🛠️ Building the App via Android CLI (Makefile & Gradle)

We provide a [Makefile](file:///home/xbill/midsommer-android/Makefile) to simplify building, deploying, and cleaning:

1. **Verify JDK Installation:**
   Ensure you have JDK 17 (or newer) installed. By default, the Makefile uses `/usr/lib/jvm/java-25-openjdk-amd64` (or you can override it using `make JAVA_HOME=/your/jdk/path ...`).

2. **Setup SDK & Build tools (if not already done):**
   ```bash
   make setup-sdk
   ```

3. **Build the Debug APK:**
   ```bash
   make build-apk
   ```
   *This automatically syncs web assets (`index.html`, `game.js`, `index.css`, images) into the Android assets directory (`app/src/main/assets/`) and outputs the APK at `app/build/outputs/apk/debug/app-debug.apk`.*

4. **Install on a connected device / Emulator:**
   With your device connected and USB debugging enabled, run:
   ```bash
   make install-apk
   ```

5. **Clean build artifacts:**
   ```bash
   make clean
   ```

6. **Monitor logs:**
   ```bash
   make logcat
   ```

### 💻 Opening in Android Studio
1. Open **Android Studio**.
2. Select **Open an existing project**.
3. Select the `midsommer-android` project directory.
4. Let Gradle synchronize, and press the **Run** button to launch.

