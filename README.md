# Fr0g Account Creator

⚠️ **Important Notice**: This platform is currently in beta phase. Accounts may be changed or deleted without notice.

[![Flutter](https://img.shields.io/badge/Flutter-3.35.5-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-Private-red.svg)](#)
[![Version](https://img.shields.io/badge/Version-1.1.0-green.svg)](#)

**Website**: [https://create.fr0g.site](https://fr0g.site)

A secure, multilingual Flutter application for creating blockchain accounts on the Fr0g platform. The app supports 14 languages and provides a user-friendly 3-step process with captcha verification and certificate generation.

## 🎯 Features

- **Multilingual**: Support for 14 languages (DE, EN, FR, ES, PT, RU, UK, ZH, JA, AR, HI, IT, CS)
- **Secure Account Creation**: 3-step process with validation
- **Captcha Verification**: Sliding puzzle captcha for security
- **Certificate Generation**: PDF export of account credentials
- **Cross-Platform**: Available for iOS, Android, Web, Windows, macOS and Linux
- **Private Keys**: Generated locally only, never transmitted



## 🚀 Quick Start

### Prerequisites

- Flutter SDK 3.35.5+
- Dart SDK 3.9.2+
- Android Studio / VS Code with Flutter plugin

### Installation

1. **Clone repository**
   ```bash
   git clone https://github.com/fr0gsite/createaccount.git
   cd createaccount
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Start application**
   ```bash
   flutter run
   ```

### Docker Setup (Optional)

```bash
docker build -t fr0g-account-creator .
docker run -p 80:80 fr0g-account-creator
```

## 📱 Usage

### Account Creation in 3 Steps:

1. **Enter Username**
   - Format: a-z (lowercase) and numbers 1-5
   - Maximum 12 characters
   - Availability is automatically checked

2. **Solve Captcha**
   - Sliding puzzle for security verification
   - Drag puzzle piece to correct position

3. **Receive Credentials**
   - Private/Public key pair generated
   - PDF certificate for download
   - QR codes for easy transfer

### Important Commands

```bash
# Generate icons
flutter pub run flutter_launcher_icons

# Generate localizations
flutter gen-l10n

# Run tests
flutter test

# Release build
flutter build apk --release
flutter build web --release
```

## ⚙️ Configuration

### Environment Variables

The app uses the following server endpoints (configured in `lib/config.dart`):

```dart
static const websiteurl = "https://fr0g.site";
static const chainserverurl = "https://testnet.fr0g.site:8443";
static const captchaserverurl = "https://captcha.fr0g.site:2096";
static const createaccountserverurl = "https://accountserver.fr0g.site:8443";
```

### Customizable Settings

- **Language**: Via language icon in the app
- **Colors**: `AppConfig.colorPrimary` and `AppConfig.colorSecondary`
- **Animation Timer**: 5 second interval for background changes

## 🏗️ Project Structure

```
lib/
├── config.dart                 # App configuration and constants
├── main.dart                   # App entry point
├── networkaction.dart          # Network API calls
├── tools.dart                  # Utility functions
├── datatypes/                  # Data models
│   ├── accountrequest.dart
│   ├── captcharesponse.dart
│   ├── globalstatus.dart
│   ├── keypair.dart
│   └── puzzle.dart
├── l10n/                       # Internationalization
│   └── app_*.arb              # Translation files
├── widget/                     # UI components
│   ├── creationprocess/       # Account creation flow
│   ├── disclaimer.dart
│   ├── printcert.dart
│   └── setlanguageview.dart
└── wordlist/                   # BIP39 word lists
    └── *.dart                 # Various languages
```

## 🌐 API Reference

### Endpoints

- **GET** `/available` - Get available account slots
- **POST** `/puzzle` - Request captcha puzzle
- **POST** `/puzzle/solution` - Verify captcha solution
- **POST** `/create` - Create account

### Data Models

```dart
class AccountRequest {
  final String message;
  final String transactionid;
}

class CaptchaResponse {
  final String puzzleImage;
  final String targetPosition;
}
```

## 🗺️ Roadmap & Status

### ✅ Completed
- [x] Multi-language support (14 languages)
- [x] 3-step account creation
- [x] Captcha integration
- [x] PDF certificate generation
- [x] Cross-platform support
- [x] Animated user interface



**Fr0g Account Creator** - Account creation for the Fr0g community
