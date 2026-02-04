# Universe App

Universe App is a cross-platform Flutter application. This repository contains the source for mobile, web, and desktop builds from a single codebase.

## Highlights
- Fast cross-platform UI built with Flutter.
- Shared code across Android, iOS, web, macOS, Windows, and Linux.
- Clean project structure and standard Flutter tooling.

## Requirements
- Flutter SDK (compatible with Dart `^3.10.1`)
- Platform-specific toolchains:
- Android: Android Studio / SDK
- iOS: Xcode (macOS only)
- Web/Desktop: Chrome or native desktop toolchains

## Quick Start
1. Install dependencies:
```
flutter pub get
```
1. Run the app:
```
flutter run
```

## Common Commands
- Run tests:
```
flutter test
```
- Analyze:
```
flutter analyze
```
- Build for release:
```
flutter build apk
```
```
flutter build ios
```
```
flutter build web
```

## Project Structure
- `lib/` Application code
- `test/` Unit and widget tests
- `android/` Android runner and build config
- `ios/` iOS runner and build config
- `web/` Web build configuration
- `windows/`, `macos/`, `linux/` Desktop runners

## Configuration
- App metadata and dependencies live in `pubspec.yaml`.
- Lint rules are in `analysis_options.yaml`.

## Versioning
Current app version is defined in `pubspec.yaml` as `1.0.0+1`.

## Roadmap
- Add a short product description and screenshots.
- Document app features and any required runtime configuration.
- Add CI and release instructions.

## License
Proprietary. All rights reserved.
