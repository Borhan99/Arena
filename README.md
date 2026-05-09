# The Project

A Flutter application built with clean architecture, BLoC state management, and Supabase backend.

## Tech Stack

- **Flutter** - UI framework
- **flutter_bloc** - State management
- **freezed** - Immutable data classes
- **dio** - HTTP client
- **hive** - Local storage
- **supabase** - Backend-as-a-service
- **get_it** - Dependency injection
- **easy_localization** - Internationalization
- **retrofit** - API generation
- **flutter_animate** - Animations

## Project Structure

```
lib/
├── core/              # Shared utilities, themes, configs
│   ├── blocs/         # Global BLoCs (theme, etc.)
│   ├── components/    # Reusable widgets
│   ├── config/       # App configuration
│   ├── di/           # Dependency injection
│   ├── network/      # Network utilities
│   └── theme/        # App theming
├── data/              # Data layer
│   ├── models/       # Data models
│   └── repositories/ # Repository implementations
├── domain/            # Domain layer
│   ├── entities/     # Business entities
│   ├── repositories/ # Repository interfaces
│   └── usecases/     # Business logic
├── features/          # Feature modules
│   ├── auth/         # Authentication
│   ├── booking/      # Booking feature
│   ├── favorites/    # Favorites feature
│   ├── home/         # Home screen
│   ├── main/         # Main navigation
│   ├── onboarding/   # Onboarding flow
│   ├── profile/      # User profile
│   └── splash/       # Splash screen
└── gen/               # Generated code
```

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Generate code (freezed, json_serializable, retrofit):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Features

- User authentication
- Booking management
- Favorites system
- Multi-language support
- Dark/Light theme
- Local data persistence

## Requirements

- Flutter SDK 3.10+
- Dart SDK 3.10+
