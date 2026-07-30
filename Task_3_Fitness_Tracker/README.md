# 🏋️‍♂️ Fitness Tracker App

A sleek, modern, and crash-safe **Fitness Tracking Mobile Application** built with **Flutter** and **SQLite**. This app allows users to log their daily physical activities, set fitness targets, monitor burned calories, active workout minutes, and step counts with real-time dynamic progress updates.

---

## ✨ Features

- 📊 **Interactive Dashboard:** Real-time visual progress tracking with dynamic progress indicators and percentage metrics based on daily calorie targets.
- 🏋️ **Manual Workout Logging:** Seamlessly record activity details, including:
  - Exercise Type (e.g., Running, Gym, Swimming)
  - Workout Duration (in minutes)
  - Calories Burned (in kcal)
  - Steps Count (Optional)
- 💾 **Local Data Persistence:** Complete offline support powered by SQLite database (`sqflite`), ensuring all logs remain stored across app restarts.
- 🌙 **Modern Dark Theme UI:** Designed with a sleek Dark Navy background, neon accents, customized rounded cards, and responsive form components.
- 🛡️ **Crash-Safe Logic:** Full input validation, graceful database fallbacks, and safe type conversion handling.

---

## 🛠️ Tech Stack & Dependencies

- **Framework:** [Flutter](https://flutter.dev/) (Dart)
- **Database:** [sqflite](https://pub.dev/packages/sqflite) (Local SQLite Storage)
- **Path Provider:** [path](https://pub.dev/packages/path) (Database directory resolution)
- **UI Components:** Material Design 3, Custom Styled TextFields, Adaptive Cards & Layouts

---

## 📁 Project Structure

```text
lib/
├── database/
│   └── db_helper.dart      # SQLite database initialization & CRUD queries
├── models/
│   └── workout_model.dart  # Data model for activity entries & JSON mapping
├── screens/
│   ├── dashboard_screen.dart # Main screen displaying goal progress & activity history
│   └── add_workout_screen.dart # Form screen for logging new activities
└── main.dart               # Main entry point & global application theme setup
