# MyFlow Mini Companion

A Flutter application for tracking training sessions and managing user data with a clean architecture approach.

## Getting Started

### Prerequisites

- Install Flutter SDK: [Set up and test drive Flutter](https://docs.flutter.dev/get-started/quick)
- [Set up Android tooling](https://docs.flutter.dev/platform-integration/android/setup)
- [Set up iOS tooling](https://docs.flutter.dev/platform-integration/ios/setup)

### Run the app

1. Clone the repository:

```bash
git clone https://github.com/fabioavelino/myflow_mini_companion_app
```

2. Navigate to the project folder and install dependencies:

```bash
cd myflow_mini_companion_app
flutter pub get
```

3. Have a simulator or a device connected to your development computer. Example to run a iOS simulator:
```bash
open -a Simulator
```

4. Run the app

```bash
flutter run
```

5. Run the small server for API call logging at training creation
```bash
dart server.dart
```

## Architecture

The project follows **Clean Architecture** principles with clear separation of concerns.

### Layer Breakdown

**Config Layer**: Contains dependency injection configuration and route definitions for navigation throughout the app.

**Data Layer (Repositories)**: Manages data operations including local storage with SharedPreferences for training persistence and user data retrieval. This is also our source of truth concerning the data in the app.

**Domain Layer (Models)**: Defines core business entities including Training and User models with JSON serialization support.

**Presentation Layer (Cubits)**: Implements the BLoC pattern using Cubit for state management, handling business logic for training and user features.
  - **State Classes**: Uses state classes with subtypes (`Initial`, `Loading`, `Loaded`, `Error`) for clear UI state representation
  - **Immutability**: All states extend `Equatable` for efficient comparison and use `const` constructors for immutable state objects
  - **Repository Pattern**: Cubits depend on repository interfaces and services injected through constructors, ensuring separation of concerns

**UI Layer**: Contains all screens and reusable widgets, including the home screen with user profile and training cards.

## Dependencies

- **dio**: Powerful HTTP client for API requests and network operations
- **flutter_bloc**: State management library implementing the BLoC pattern
- **equatable**: Simplifies equality comparisons for state management
- **path_provider**: Access to commonly used locations on the filesystem
- **shared_preferences**: Persistent key-value storage for local data

## Improvements needed

- UI loading (circular progression indicator, skeleton loader, etc...)
- Handle error during POST API call (only catched at the moment to avoid Exception)
- Better consistency between text styles used in the app

## References

### Architecture guides

- [Flutter guide to app architecture](https://docs.flutter.dev/app-architecture/guide)
- [BLoC Architecture introduction](https://bloclibrary.dev/architecture/)
- [Flutter official architecture recommandation app](https://github.com/flutter/samples/tree/main/compass_app)
