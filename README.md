# SibLearn – iOS App

A single-screen vocabulary learning app using SwiftUI, SwiftData, and The Composable Architecture (TCA). Learners can add cards, flip through them, type the meaning, get feedback, and track XP progress. All data is persisted locally.

---

## 🧱 Architecture

- **Data Layer** server side requests and data base operations.
- **Domain Layer** contains any logics of application
- **Feature Layer - MV reducer-based** using [TCA](https://github.com/pointfreeco/swift-composable-architecture) contains views
- **SwiftData** is used for local persistence (`FlashCard`, `XPTracker`)
- All state, actions, and business logic in `Feature Layer` are centralized in `FlashCardFeature` and `AddCardFeature`
- Views are reactive and testable using `Store` and `WithViewStore`

---

## 🚀 Build & Run

1. Requires **Xcode 16+**, iOS 18+
2. Clone repo and open `.xcodeproj` or `.xcworkspace`
3. Run the app on an iOS simulator or device (no networking needed)

---

## 🧪 Testing

- Run unit tests via `⌘U` or from the **Test Navigator**
- Uses `XCTest` + `TCA.TestStore`
- Key logic tested:
  - Answer validation
  - XP increment
  - State transitions (e.g., adding cards, flipping)

---

## ⚖️ Trade-offs

- Used in-memory SwiftData for testing; real persistence requires iOS 18+
- This Clean Architecture and TCA adds complexity but ensures scalable state handling and testability
