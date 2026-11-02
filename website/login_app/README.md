# login_app

Mantra cross-platform hybrid application: login_app

A cross-platform hybrid application built with the **Mantra Programming Language**.

## Target Platforms
- `ios`
- `android`
- `web`

## Architecture Overview
```text
login_app/
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


In the Mantra Widgets architecture, the application developer writes these methods in Mantra (inside a Controller or State class), not in HTML or JavaScript.

Here is the complete breakdown of who creates them, where they live, and how the actions execute across Web, Android, and iOS.

1. Who Creates handleLogin and handleSocialLogin?

👉 The Developer creates them in Mantra code — specifically in a Controller or State class (e.g., AuthState or AuthController).

mantra
# src/controllers/auth_controller.mantra
from src.state.app_state import AuthState
pub class AuthController:
    def __init__(self, state: AuthState):
        self.state = state
    pub def handle_login(self, email: String, pass: String) -> Bool:
        self.state.set_email(email)
        self.state.set_password(pass)
        
        if not self.state.validate():
            return False
            
        # Trigger auth API / service call
        return self.state.login()
    pub def handle_social_login(self, provider: String) -> Bool:
        print("Authenticating with: " + provider)
        # Initiates OAuth flow via Mantra Auth Service
        self.state.set_email(provider + "_user@example.com")
        self.state.is_logged_in = True
        return True

The developer should never have to write platform-specific JavaScript, Java, or Swift just to handle a button click or form submit.

2. How the Developer Binds Them in the Widget Tree

Instead of passing hardcoded raw JavaScript strings, the widget takes a high-level Action / Event ID or a method reference:

mantra
# Inside LoginScreen.build()
let sign_in = Button("Sign In")
sign_in.on_click("auth.login")           # Semantic action name
let google = SocialButton("Google", "google")
google.on_click("auth.social:Google")    # Semantic action with payload
3. How the Actions Are Performed Across Platforms

The compiler and the Mantra UI Engine (Platform Bridge) translate that single Mantra action into the native platform mechanism:

[ User Interaction ]
        │
   ┌────┴────────────────────────┬─────────────────────────┐
   ▼                             ▼                         ▼
  Web                         Android                     iOS
DOM Click Event           View.OnClickListener        SwiftUI Action
   │                             │                         │
Mantra Web Bridge (WASM/JS)   Mantra Android Bridge (JNI) Mantra iOS Bridge (FFI)
   └─────────────────────────────┼─────────────────────────┘
                                 ▼
                     [ Mantra Runtime Engine ]
                                 │
                   Dispatches event: "auth.login"
                                 │
                                 ▼
                   AuthState.login() executes!
                                 │
                                 ▼
             State updates (is_logged_in = true)
                                 │
                                 ▼
       UI triggers re-render / displays Success Screen
Detailed by Platform:
Platform	Who captures the event	How it reaches Mantra
🌐 Web	Browser DOM (click event on <button>)	Mantra Web Bridge (MantraBridge.emit('auth.login', payload)): Calls into compiled WASM / JS runtime export which invokes AuthController.handle_login.
🤖 Android	Android OS (View.OnClickListener)	Mantra Android Bridge: Native Android activity intercepts the tap, passes the event via JNI to the compiled Mantra library.
🍎 iOS	UIKit / SwiftUI (Button(action: { ... }))	Mantra iOS Bridge: SwiftUI closure dispatches event via C-ABI / FFI directly into the Mantra native binary.
4. What Happens Inside handleLogin? (The Actual Action)

When handleLogin is triggered, the action typically performs 3 steps:

Validation & UI State:
Checks email format and password length.
Sets button.set_loading(True) to show a spinner.
Network / Auth Request:
Calls the backend (e.g. http.post("http://api.cinemantra.dev/api/auth/login", credentials)).
Or for social auth: opens the OAuth provider popup / URL.
State Mutation & Screen Transition:
On success: updates AuthState.is_logged_in = True and sets user profile.
Screen re-renders to show the SuccessPanel or navigates to HomeScreen.
Summary
Who writes the methods: The developer, in pure Mantra (src/state/app_state.mantra or src/controllers/auth_controller.mantra).
Who executes the UI event: The Mantra Platform Bridge captures the native click (DOM on Web, OnClickListener on Android, Button action on iOS) and routes it back into your Mantra controller.
Why this matters: The developer writes business logic once in Mantra, and it functions identically across Web, Android, and iOS without writing raw HTML/JS or native glue code.


=================

All generated build artifacts for the web module have been cleaned.

Here is the complete walkthrough of what web files exist, how they are generated, and how the Mantra compiler creates them during create, build, and run.

1. The Web Module Files Breakdown

When working with a hybrid frontend app in Mantra, there are two categories of files in platforms/web/:

platforms/web/
├── index.html        ← [Scaffolded] Host HTML shell that loads WASM & styles
├── manifest.json     ← [Scaffolded] PWA metadata (app name, colors, icons)
├── app.wasm          ← [Generated on Build] Compiled WebAssembly binary
└── app.wat           ← [Generated on Build] WebAssembly text format (for debugging)
File	Who creates it?	When?	What is its purpose?
index.html	mantra create	Project scaffolding	The browser shell containing the root DOM element (#mantra-root) and CSS design tokens.
manifest.json	mantra create	Project scaffolding	Standard Progressive Web App (PWA) config.
app.wasm	mantra build web	Build / Compilation	Compiled WebAssembly binary generated from your .mantra source code by the Mantra IR/WASM compiler.
app.wat	mantra build web	Build / Compilation	Human-readable WebAssembly Text representation of app.wasm.
web/ symlink	Dev environment	Project setup	Symlink pointing web -> platforms/web so standard HTTP servers can serve ./web.
2. How Files are Generated Step-by-Step
Step A: Initial Scaffolding (mantra create)

When you run:

bash
mantra create --type frontend --project-name login_app --platforms ios,android,web

The Mantra CLI (mantra_mdk::scaffold::frontend):

Reads --platforms and sees web.
Creates the directory platforms/web/.
Writes default template files:
platforms/web/index.html
platforms/web/manifest.json
Adds web = "platforms/web" under [platforms] in mantra.toml.
Step B: Compiling WebAssembly (mantra build web)

When you run:

bash
mantra build web

The Mantra compiler executes this pipeline:

[ .mantra source files ]
           │
           ▼
1. Parser & Typechecker   → Validates syntax & types
           │
           ▼
2. AST Lowering           → Lowers to intermediate representation (IR)
           │
           ▼
3. WasmEmitter            → Generates raw WebAssembly bytecode
           │
           ├─► writes platforms/web/app.wasm   (binary)
           └─► writes platforms/web/app.wat    (text format)

Console output during this process:

text
Compiling WebAssembly target (wasm32-unknown-unknown)...
✓ Emitted WebAssembly binary : platforms/web/app.wasm (40 bytes)
✓ Emitted WebAssembly text   : platforms/web/app.wat
✓ Web application shell      : web/index.html
✓ Web target ready to serve  : python3 -m http.server -d web
Step C: Running the Web App (mantra run -d chrome)

When you run:

bash
mantra run -d chrome --web-port 4300

Mantra performs two actions automatically:

Implicit Build: Recompiles platforms/web/app.wasm and app.wat so changes in your .mantra files are immediately fresh.
Starts Embedded HTTP Server:
Checks platforms/web (or ./web).
Serves index.html, manifest.json, and app.wasm on http://127.0.0.1:4300.
Opens Chrome targeting the local URL.
3. Hands-On Test Commands

You can run these commands anytime in your terminal:

bash
cd /Users/user/Documents/workspace/Mantra-Development/mantra_website/mantra_web/examples/login_app
# 1. Clean generated WASM artifacts
rm -f platforms/web/app.wasm platforms/web/app.wat
# 2. Rebuild the Web module
mantra build web
# 3. Check what was generated
ls -la platforms/web/
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
