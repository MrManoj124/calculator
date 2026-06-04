# mastery_tools

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Mastery Tools is a 3-in-1 mobile application built with Flutter/Dart. It elegantly combines a Scientific Calculator, a Precision Stopwatch with Lap tracking, and a versatile Measurement Converter into a single, clean user interface.

Originally designed as a web app (HTML/CSS/JS), it has been completely rewritten natively for mobile platforms to ensure fast performance and offline availability.

## ✨ Features

1. **Scientific Calculator**
   * Basic arithmetic operations (+, -, *, /)
   * Trigonometric functions (sin, cos, tan)
   * Logarithmic functions (log, ln)
   * Exponents and Square Roots (x², sqrt)
   * Built-in constants (π, e)
2. **Stopwatch**
   * Track time down to the centisecond.
   * Start, Pause, and Reset functionality.
   * Lap tracking with a scrollable history list.
3. **Measurement Converter**
   * **Length:** Meters, Kilometers, Centimeters, Millimeters, Inches, Feet, Yards, Miles.
   * **Weight:** Kilograms, Grams, Milligrams, Pounds, Ounces.
   * **Temperature:** Celsius, Fahrenheit, Kelvin.

## 🚀 Step-by-Step Guide: How to Run This Project

### Step 1: Install Flutter
If you haven't already, download and install the Flutter SDK from the [official Flutter website](https://docs.flutter.dev/get-started/install).

### Step 2: Create a New Project
Open your terminal or command prompt and run the following command to generate a new Flutter project:
```bash
flutter create mastery_tools
cd mastery_tools
Step 3: Add Dependencies
This app requires the math_expressions package to handle complex mathematical parsing safely. Add it to your project by running:

Bash
flutter pub add math_expressions
(Alternatively, you can manually add math_expressions: ^2.4.0 to your pubspec.yaml file under dependencies and run flutter pub get.)

Step 4: Add the Source Code
Navigate to the lib folder inside your project directory. Replace the contents of the default main.dart file with the Dart code provided in this repository.

Step 5: Run the App
Connect your Android/iOS device, or start up a simulator/emulator. Then, run the application using:

Bash
flutter run

## ✨ New Features
- **GPA Calculator (New Page):** Navigate to a dedicated calculation screen to track your academic performance.
- **Advanced Navigation:** Features a hybrid navigation system where standard tools swap in place, while the GPA tool opens as a separate page with a native back button.

## 🧮 How to Calculate GPA
1. Tap the **GPA** icon in the bottom navigation bar.
2. The app will navigate to a new screen.
3. Select your **Letter Grade** from the dropdown.
4. Enter the **Credit Hours** for that course.
5. Click **Add Course** to include more subjects.
6. The GPA updates automatically at the bottom.
7. Use the **Back Arrow** in the top-left to return to the main dashboard.

## 🚀 Setup Instructions
1. Ensure Flutter is installed (`flutter doctor`).
2. Clone the repository.
3. Add the calculation dependency:
   ```bash
   flutter pub add math_expressions