# Amiibo Browser

A SwiftUI iOS app for browsing Nintendo Amiibo figures, built as a personal learning project to explore SwiftUI, Combine, and protocol-oriented architecture.

---

## Features

- Browse Amiibo organized by **Series** or **Game Series**
- **Real-time search** filtering across all lists
- **Detail view** with character info, type, and regional release dates (AU, EU, JP, NA)
- **Offline detection** with in-app alert when network is unavailable
- Hierarchical navigation: Series → Amiibo List → Detail

---

## Tech Stack

| Layer | Technology |
|---|---|
| UI | SwiftUI |
| Reactive / State | Combine |
| Networking | URLSession |
| Connectivity | Network framework (NWPathMonitor) |
| Testing | XCTest |
| Language | Swift 5.0 |

No third-party dependencies — pure Apple frameworks only.

---

## Architecture

The project follows **MVVM** with a protocol-oriented service and networking layer.

```
Amiibo/
├── SupportingFiles/        # App entry point, assets, config
├── Source/
│   ├── Models/             # Decodable API response models
│   ├── Networking/         # NetworkManager, error handling, config
│   ├── Requests/           # AmiiboRequest enum (endpoint routing)
│   ├── Requesters/         # URLSession-based HTTP requester
│   ├── Service/            # AmiiboService (business logic)
│   └── Extensions/         # String, View utilities
└── Modules/
    ├── Views/
    │   ├── AmiiboList/         # Series/Game Series list + ViewModel
    │   ├── AmiiboSerieList/    # Individual amiibo list + ViewModel
    │   └── AmiiboDetail/       # Amiibo detail view
    └── CustomViews/
        ├── CardViews/          # Reusable list item cards
        ├── Views/              # SearchBar, HomeView
        └── Modifiers/          # .onLoad(), .isHidden()
```

**Key patterns used:**
- Dependency injection via protocol type aliases (`HasAmiiboServiceType`, `HasNetworkMonitorType`)
- Enum-based request routing (`AmiiboRequest`)
- Reactive search with Combine's `removeDuplicates()`
- Custom `ViewModifier`s for reusable view behavior

---

## Data Source

The app consumes the public [Amiibo API](https://amiiboapi.com) — no API key required.

| Endpoint | Description |
|---|---|
| `/api/amiiboseries/` | All Amiibo series |
| `/api/gameseries/` | All game series |
| `/api/amiibo/?amiiboSeries={serie}` | Amiibos by series |
| `/api/amiibo/?gameseries={gameSerie}` | Amiibos by game series |

---

## Requirements

- Xcode 14.2+
- iOS 16.2+
- Swift 5.0+

---

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/rodval/amiibo-app-swiftui.git
   ```

2. Open the project in Xcode:
   ```bash
   cd amiibo-app-swiftui
   open Amiibo.xcodeproj
   ```

3. Select a simulator or connected device running **iOS 16.2 or later**.

4. Press **⌘R** to build and run.

No additional setup, package installation, or API keys are needed.

---

## Running Tests

Open the project in Xcode and press **⌘U** to run the test suite, or use:

```bash
xcodebuild test \
  -scheme Amiibo \
  -destination 'platform=iOS Simulator,name=iPhone 14'
```

