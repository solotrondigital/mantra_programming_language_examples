# ramapp

ramapp cross-platform application

A cross-platform hybrid application built with the **Mantra Programming Language**.

## Target Platforms
- `ios`
- `android`
- `web`

## Architecture Overview
```text
ramapp/
├── mantra.toml
├── README.md
├── .gitignore
├── src/
│   ├── app/           # Application root and bootstrap
│   ├── components/    # Reusable UI components
│   ├── screens/       # Application screens / views
│   ├── navigation/    # Screen routing and navigation stack
│   ├── services/      # Cross-platform HTTP/API services
│   ├── state/         # State management store
│   ├── styles/        # Global theme and styling
│   └── main.mantra    # Application entry point
├── assets/            # Static assets (images, icons)
├── platforms/         # Platform bridge projects
│   ├── ios/           # iOS Swift bridge (WebKit WKWebView)
│   ├── android/       # Android Kotlin bridge (WebView)
│   └── web/           # WebAssembly & PWA shell
└── tests/             # Unit and integration test suite
```

## Getting Started

### Development & Running
```bash
# Web browser runtime
mantra run -d chrome --web-port 4300

# Android device/emulator runtime
mantra run -d android

# iOS simulator runtime
mantra run -d ios
```

### Building for Release
```bash
# Compile WebAssembly bundle
mantra build web --release

# Build Android APK
mantra build apk --release

# Build Android App Bundle (AAB for Google Play)
mantra build appbundle --release
```

### Running Tests
```bash
mantra test
```

## Mantra Project Creation Reference
Use these reference commands to scaffold new Mantra projects:

### 1. Frontend Cross-Platform Application (iOS, Android, Web)
```bash
mantra create \
  --type frontend \
  --org com.testapp \
  --project-name testapp \
  --platforms ios,android,web \
  --description "TestApp cross-platform application"
```

### 2. Backend REST API
```bash
mantra create \
  --type backend \
  --service REST \
  --org com.testapp \
  --project-name testapp \
  --description "TestApp REST API backend"
```

### 3. Backend GraphQL API
```bash
mantra create \
  --type backend \
  --service GRAPHQL \
  --org com.testapp \
  --project-name testapp \
  --description "TestApp GraphQL backend"
```
