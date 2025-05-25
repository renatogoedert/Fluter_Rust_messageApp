<<<<<<< HEAD
# Fluter_Rust_messageApp
Message aoo using fluter and rust
=======
# Flutter Camera & Rust Bridge App

This repository hosts a simple Flutter message application that integrates Rust functionality via **flutter_rust_bridge**.

The app’s UI is organized with **StatefulWidget** screens and **StatelessWidget** components, following established Flutter best practices for clear separation of concerns and efficient rebuilds.

All Data is persisted in plain-text files within the device’s local storage.

Camera capture and image selection leverage the **image_picker** plugin, demonstrating access to both device camera and gallery.

## Architecture

### Screen & Component Design  
Each screen is implemented as a `StatefulWidget` to manage asynchronous operations (e.g., invoking the camera or reading files), while all reusable UI elements are `StatelessWidget`s to promote immutability and predictable rendering.

### Rust Bridge Integration  
Rust functions are exposed to Flutter via code-generated bindings from `flutter_rust_bridge`, enabling zero-cost abstractions between Dart and Rust domains.

## Installation

### Prerequisites

- **Flutter SDK** (>= 3.0)  
- **Rust toolchain** with `cargo`  
- **flutter_rust_bridge** CLI for binding generation

### Steps

1. **Clone the repository**  
   ```bash
   git clone https://github.com/yourusername/flutter_camera_rust_app.git
   cd flutter_camera_rust_app
   ```

2. **Install Dart & Flutter dependencies**  
   ```bash
   flutter pub get
   ```

3. **Generate Rust bindings**  
   ```bash
   flutter_rust_bridge_codegen --rust-input ./rust/src/api.rs --dart-output ./lib/bridge_generated.dart
   ```

4. **Run the app**  
   ```bash
   flutter run
   ```

## Usage

1. Launch the app on your device or simulator.  
2. Create an account
3. Log in the account
4. Change avatar with Camera
5. Create a conversation
6. Chnage convesation image changing Url
7. Send messages to conversations
>>>>>>> master
